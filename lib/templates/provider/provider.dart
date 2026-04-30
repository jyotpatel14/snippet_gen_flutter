import 'dart:io';

void generateProvider(String path, String pascal, String lower) {
  final file = File('$path/${lower}_provider.dart');

  file.writeAsStringSync('''

import 'model/${lower}_model.dart';

class ${pascal}Provider extends CommonProvider {
  ${pascal}Provider() {
    isLoading = CommonProviderPrimitiveParameter(value: false, notify: notify);
    isOperating = CommonProviderPrimitiveParameter(value: false, notify: notify);

    items = CommonProviderListParameter<${pascal}Model>(list: [], notify: notify);
    selectedItem = CommonProviderPrimitiveParameter<${pascal}Model>(
        value: null, notify: notify);
  }

  late CommonProviderPrimitiveParameter<bool> isLoading;
  late CommonProviderPrimitiveParameter<bool> isOperating;

  late CommonProviderListParameter<${pascal}Model> items;
  late CommonProviderPrimitiveParameter<${pascal}Model> selectedItem;

  void reset({bool isNotify = true}) {
    isLoading.set(value: false, isNotify: isNotify);
    isOperating.set(value: false, isNotify: isNotify);
    items.setList(list: [], isNotify: isNotify);
    selectedItem.set(value: null, isNotify: isNotify);
  }
}
''');
}
