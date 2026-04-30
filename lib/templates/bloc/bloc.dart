import 'dart:io';

void generateBloc(String path, String pascal, String lower) {
  File('$path/${lower}_bloc.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';

import '${lower}_event.dart';
import '${lower}_state.dart';
import '${lower}_repository.dart';

class ${pascal}Bloc extends Bloc<${pascal}Event, ${pascal}State> {
  final ${pascal}Repository repository;

  ${pascal}Bloc({required this.repository}) : super(const ${pascal}State()) {
    on<GetAll${pascal}Event>(_onGetAll);
    on<Get${pascal}ByIdEvent>(_onGetById);
    on<Create${pascal}Event>(_onCreate);
    on<Update${pascal}Event>(_onUpdate);
    on<Delete${pascal}Event>(_onDelete);
  }

  Future<void> _onGetAll(
      GetAll${pascal}Event event, Emitter<${pascal}State> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await repository.getAll();
      emit(state.copyWith(isLoading: false, items: result ?? []));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onGetById(
      Get${pascal}ByIdEvent event, Emitter<${pascal}State> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final result = await repository.getById(event.id);
      emit(state.copyWith(isLoading: false, selectedItem: result));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onCreate(
      Create${pascal}Event event, Emitter<${pascal}State> emit) async {
    emit(state.copyWith(isOperating: true));

    try {
      await repository.create(event.request);
      emit(state.copyWith(isOperating: false));
    } catch (e) {
      emit(state.copyWith(isOperating: false, error: e.toString()));
    }
  }

  Future<void> _onUpdate(
      Update${pascal}Event event, Emitter<${pascal}State> emit) async {
    emit(state.copyWith(isOperating: true));

    try {
      await repository.update(event.id, event.request);
      emit(state.copyWith(isOperating: false));
    } catch (e) {
      emit(state.copyWith(isOperating: false, error: e.toString()));
    }
  }

  Future<void> _onDelete(
      Delete${pascal}Event event, Emitter<${pascal}State> emit) async {
    emit(state.copyWith(isOperating: true));

    try {
      await repository.delete(event.id);
      emit(state.copyWith(isOperating: false));
    } catch (e) {
      emit(state.copyWith(isOperating: false, error: e.toString()));
    }
  }
}
''');
}
