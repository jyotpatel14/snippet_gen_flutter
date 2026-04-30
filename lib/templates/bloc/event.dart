import 'dart:io';

void generateEvent(String path, String pascal) {
  File('$path/${pascal.toLowerCase()}_event.dart').writeAsStringSync('''
abstract class ${pascal}Event {}

// GET ALL
class GetAll${pascal}Event extends ${pascal}Event {}

// GET BY ID
class Get${pascal}ByIdEvent extends ${pascal}Event {
  final String id;
  Get${pascal}ByIdEvent(this.id);
}

// CREATE
class Create${pascal}Event extends ${pascal}Event {
  final dynamic request;
  Create${pascal}Event(this.request);
}

// UPDATE
class Update${pascal}Event extends ${pascal}Event {
  final String id;
  final dynamic request;

  Update${pascal}Event(this.id, this.request);
}

// DELETE
class Delete${pascal}Event extends ${pascal}Event {
  final String id;
  Delete${pascal}Event(this.id);
}
''');
}
