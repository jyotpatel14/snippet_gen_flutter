import 'dart:io';

void generateState(String path, String pascal) {
  File('$path/${pascal.toLowerCase()}_state.dart').writeAsStringSync('''
class ${pascal}State {
  final bool isLoading;
  final bool isOperating;

  final List<dynamic> items;
  final dynamic selectedItem;

  final String? error;

  const ${pascal}State({
    this.isLoading = false,
    this.isOperating = false,
    this.items = const [],
    this.selectedItem,
    this.error,
  });

  ${pascal}State copyWith({
    bool? isLoading,
    bool? isOperating,
    List<dynamic>? items,
    dynamic selectedItem,
    String? error,
  }) {
    return ${pascal}State(
      isLoading: isLoading ?? this.isLoading,
      isOperating: isOperating ?? this.isOperating,
      items: items ?? this.items,
      selectedItem: selectedItem ?? this.selectedItem,
      error: error,
    );
  }
}
''');
}
