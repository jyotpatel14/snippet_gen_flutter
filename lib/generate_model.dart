import 'dart:io';

class GeneratedClass {
  final String name;
  final Map<String, dynamic> json;

  GeneratedClass(this.name, this.json);
}

String _toCamelCase(String input) {
  final parts = input.split('_');
  return parts.first +
      parts.skip(1).map((e) => e[0].toUpperCase() + e.substring(1)).join();
}

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

/// Generates a Dart model from a JSON file.
///
/// Supports:
/// - Nested objects → nested classes
/// - Safe parsing via ParsingHelper
///
/// [rootClassName] is the name of the main model class.
/// [json] is the decoded JSON map.
/// [sourcePath] is the file path of the input JSON.

String generateModel(
  String rootClassName,
  Map<String, dynamic> json,
  String sourcePath,
) {
  final classes = <GeneratedClass>[];

  void process(String className, Map<String, dynamic> json) {
    classes.add(GeneratedClass(className, json));

    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        final nestedName = _capitalize(_toCamelCase(key));
        process(nestedName, value);
      }
    });
  }

  process(rootClassName, json);

  final buffer = StringBuffer();

  // ✅ Add ParsingHelper import
  buffer.writeln("import 'package:your_project/utils/parsing_helper.dart';\n");

  for (final cls in classes.reversed) {
    buffer.writeln(_buildClass(cls.name, cls.json));
  }

  final file = File(sourcePath);
  final dir = file.parent.path;
  final outputPath = '$dir/${rootClassName.toLowerCase()}.dart';

  File(outputPath).writeAsStringSync(buffer.toString());

  print("✅ Generated at: $outputPath");

  return outputPath;
}

String _buildClass(String className, Map<String, dynamic> json) {
  final buffer = StringBuffer();

  buffer.writeln('class $className {');

  /// Fields
  json.forEach((key, value) {
    final field = _toCamelCase(key);
    final type = _getType(key, value);
    buffer.writeln('  final $type? $field;');
  });

  buffer.writeln();

  /// Constructor
  buffer.write('  $className({');
  json.forEach((key, _) {
    buffer.write('this.${_toCamelCase(key)}, ');
  });
  buffer.writeln('});\n');

  /// fromJson
  buffer.writeln('  factory $className.fromJson(Map<String, dynamic> json) {');
  buffer.writeln('    return $className(');

  json.forEach((key, value) {
    buffer.writeln("      ${_parseWithHelper(key, value)}");
  });

  buffer.writeln('    );');
  buffer.writeln('  }\n');

  /// toJson
  buffer.writeln('  Map<String, dynamic> toJson() {');
  buffer.writeln('    final data = <String, dynamic>{};');

  json.forEach((key, value) {
    final field = _toCamelCase(key);

    if (value is Map<String, dynamic>) {
      buffer.writeln(
        "    if ($field != null) data['$key'] = $field!.toJson();",
      );
    } else {
      buffer.writeln("    data['$key'] = $field;");
    }
  });

  buffer.writeln('    return data;');
  buffer.writeln('  }');

  buffer.writeln('}\n');

  return buffer.toString();
}

String _parseWithHelper(String key, dynamic value) {
  final field = _toCamelCase(key);

  if (value is String) {
    return "$field: ParsingHelper.parseStringNullableMethod(json['$key']),";
  }

  if (value is int) {
    return "$field: ParsingHelper.parseIntNullableMethod(json['$key']),";
  }

  if (value is double) {
    return "$field: ParsingHelper.parseDoubleNullableMethod(json['$key']),";
  }

  if (value is bool) {
    return "$field: ParsingHelper.parseBoolNullableMethod(json['$key']),";
  }

  if (value is List) {
    if (value.isNotEmpty && value.first is String) {
      return "$field: ParsingHelper.parseListMethod<dynamic, String>(json['$key']),";
    }
    return "$field: ParsingHelper.parseListMethod<dynamic, dynamic>(json['$key']),";
  }

  if (value is Map<String, dynamic>) {
    final nested = _capitalize(_toCamelCase(key));
    return "$field: json['$key'] != null ? $nested.fromJson(json['$key']) : null,";
  }

  return "$field: json['$key'],";
}

String _getType(String key, dynamic value) {
  if (value is int) return 'int';
  if (value is double) return 'double';
  if (value is bool) return 'bool';
  if (value is String) return 'String';

  if (value is List) {
    if (value.isEmpty) return 'List<dynamic>';
    final first = value.first;
    if (first is String) return 'List<String>';
    return 'List<dynamic>';
  }

  if (value is Map<String, dynamic>) {
    return _capitalize(_toCamelCase(key));
  }

  return 'dynamic';
}
