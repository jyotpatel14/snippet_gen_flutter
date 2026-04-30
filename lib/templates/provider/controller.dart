import 'dart:io';

void generateController(String path, String pascal, String lower) {
  final file = File('$path/${lower}_controller.dart');

  file.writeAsStringSync('''
import '${lower}_provider.dart';
import '${lower}_repository.dart';

class ${pascal}Controller {
  late ${pascal}Provider _provider;
  late ${pascal}Repository _repository;

  ${pascal}Controller({
    ${pascal}Provider? provider,
    ${pascal}Repository? repository,
  }) {
    _provider = provider ?? ${pascal}Provider();
    _repository = repository ?? ${pascal}Repository(apiController: ApiController());
  }

  ${pascal}Provider get provider => _provider;
  ${pascal}Repository get repository => _repository;

  Future<void> getAll() async {
    if (_provider.isLoading.get()) return;

    try {
      _provider.isLoading.set(value: true, isNotify: true);

      final result = await _repository.getAll();

      _provider.items.setList(list: result ?? [], isNotify: true);
    } finally {
      _provider.isLoading.set(value: false, isNotify: true);
    }
  }

  Future<void> getById(String id) async {
    if (_provider.isLoading.get()) return;

    try {
      _provider.isLoading.set(value: true, isNotify: true);

      final result = await _repository.getById(id);

      _provider.selectedItem.set(value: result, isNotify: true);
    } finally {
      _provider.isLoading.set(value: false, isNotify: true);
    }
  }

  Future<void> create(Create${pascal}RequestDto request) async {
    if (_provider.isOperating.get()) return;

    try {
      _provider.isOperating.set(value: true, isNotify: true);

      await _repository.create(request);
    } finally {
      _provider.isOperating.set(value: false, isNotify: true);
    }
  }

  Future<void> update(String id, Update${pascal}RequestDto request) async {
    if (_provider.isOperating.get()) return;

    try {
      _provider.isOperating.set(value: true, isNotify: true);

      await _repository.update(id, request);
    } finally {
      _provider.isOperating.set(value: false, isNotify: true);
    }
  }

  Future<void> delete(String id) async {
    if (_provider.isOperating.get()) return;

    try {
      _provider.isOperating.set(value: true, isNotify: true);

      await _repository.delete(id);
    } finally {
      _provider.isOperating.set(value: false, isNotify: true);
    }
  }
}
''');
}
