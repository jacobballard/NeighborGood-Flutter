// import 'dart:typed_data';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:universal_html/html.dart';

// import 'abstract_file_reader_service.dart';

// class FileReaderServiceWeb implements FileReaderService {
//   @override
//   Future<Uint8List> read(String path) async {

//     final blob = Blob([path]);
//     final reader = FileReader();

//     final completer = Completer<Uint8List>();
//     reader.onLoadEnd.listen((event) {
//       completer.complete(reader.result as Uint8List);
//     });
//     reader.onError.listen((event) {
//       completer.completeError(event);
//     });
//     reader.readAsArrayBuffer(blob);

//     return completer.future;
//   }
// }

// FileReaderService getFileReader() => FileReaderServiceWeb();
import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:image_picker/image_picker.dart';
import 'abstract_file_reader_service.dart';

class FileReaderServiceWeb implements FileReaderService {
  @override
  Future<Uint8List> read(String path, XFile file) async {
    return await file.readAsBytes();
  }
}

FileReaderService getFileReader() => FileReaderServiceWeb();
