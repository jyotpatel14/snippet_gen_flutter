import 'dart:typed_data';

class EventMultipartFileUploadModel {
  final String fieldName;
  final String? fileName;
  final String? filePath;
  final Uint8List? bytes;

  const EventMultipartFileUploadModel({
    required this.fieldName,
    this.fileName,
    this.filePath,
    this.bytes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "fieldName": fieldName,
      "fileName": fileName,
      "filePath": filePath,
      "bytes": bytes,
    };
  }

  @override
  String toString() {
    return "EventFileUploadParametersModel(${toMap()})";
  }
}
