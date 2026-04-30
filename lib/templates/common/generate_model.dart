import 'dart:io';

void generateModel(String path, String pascal, String lower) {
  File('$path/${lower}_model.dart').writeAsStringSync('''
class ${pascal}Model {
  // TODO: define fields
}
''');
}

void generateDtos(String path, String pascal, String lower) {
  File('$path/create_${lower}_request_dto.dart').writeAsStringSync('''
class Create${pascal}RequestDto {}
''');

  File('$path/update_${lower}_request_dto.dart').writeAsStringSync('''
class Update${pascal}RequestDto {}
''');

  File('$path/${lower}_response_dto.dart').writeAsStringSync('''
class ${pascal}ResponseDto {}
''');
}
