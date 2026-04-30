import 'dart:io';

import 'package:snippet_gen/templates/bloc/bloc.dart';
import 'package:snippet_gen/templates/bloc/event.dart';
import 'package:snippet_gen/templates/bloc/state.dart';
import 'package:snippet_gen/templates/common/generate_model.dart';
import 'package:snippet_gen/templates/common/repository.dart';

void generateBlocResource(String entity, bool isRepoAbstract) {
  final lower = entity.toLowerCase();
  final pascal = entity;

  final baseDir = Directory('lib/blocs/$lower');
  final modelDir = Directory('lib/blocs/$lower/model');

  baseDir.createSync(recursive: true);
  modelDir.createSync(recursive: true);

  generateBloc(baseDir.path, pascal, lower);
  generateEvent(baseDir.path, pascal);
  generateState(baseDir.path, pascal);
  generateRepository(baseDir.path, pascal, lower, isRepoAbstract);

  generateModel(modelDir.path, pascal, lower);
  generateDtos(modelDir.path, pascal, lower);

  print("✅ BLoC resource for $entity generated");
}
