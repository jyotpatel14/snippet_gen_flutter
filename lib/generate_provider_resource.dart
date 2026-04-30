import 'dart:io';

import 'package:snippet_gen/templates/common/generate_model.dart';
import 'package:snippet_gen/templates/provider/controller.dart';
import 'package:snippet_gen/templates/provider/provider.dart';
import 'package:snippet_gen/templates/common/repository.dart';

void generateProviderResource(String entity) {
  final lower = entity.toLowerCase();
  final pascal = entity;

  final backendDir = Directory('lib/backend/$lower');
  final modelDir = Directory('lib/backend/$lower/model');

  backendDir.createSync(recursive: true);
  modelDir.createSync(recursive: true);

  generateController(backendDir.path, pascal, lower);
  generateProvider(backendDir.path, pascal, lower);
  generateRepository(backendDir.path, pascal, lower);

  generateDtos(modelDir.path, pascal, lower);
  generateModel(modelDir.path, pascal, lower);

  print("✅ $entity resource generated successfully");
}
