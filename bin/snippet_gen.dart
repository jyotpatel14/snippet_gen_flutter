import 'dart:io';
import 'dart:convert';

import 'package:snippet_gen/generate_provider_resource.dart';
import 'package:snippet_gen/generate_bloc_resource.dart';
import 'package:snippet_gen/generate_model.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    printUsage();
    return;
  }

  final command = arguments[0];

  switch (command) {
    case 'generate':
      handleGenerate(arguments);
      break;

    case 'model':
      handleModel(arguments);
      break;

    default:
      print("Invalid command.");
      printUsage();
  }
}

void handleGenerate(List<String> arguments) {
  if (arguments.length < 3) {
    print("Usage: generate <provider|bloc> <entity>");
    return;
  }

  final type = arguments[1];
  final entity = arguments[2];

  switch (type) {
    case 'provider':
      generateProviderResource(entity);
      break;

    case 'bloc':
      generateBlocResource(entity);
      break;

    default:
      print("Invalid type. Use: provider or bloc");
  }
}

void handleModel(List<String> arguments) {
  if (arguments.length < 3) {
    print("Usage: model <json_file_path> <ClassName>");
    return;
  }

  final filePath = arguments[1];
  final className = arguments[2];

  final file = File(filePath);

  if (!file.existsSync()) {
    print("File not found: $filePath");
    return;
  }

  final jsonString = file.readAsStringSync();
  final jsonData = json.decode(jsonString);

  generateModel(className, jsonData, filePath);
}

void printUsage() {
  print('''
Usage:
  dart run snippet_gen generate <provider|bloc> <entity>
  dart run snippet_gen model <json_file_path> <ClassName>
''');
}
