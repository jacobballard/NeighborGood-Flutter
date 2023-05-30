import 'dart:io' as io;
import 'dart:typed_data';
import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'file_reader_service.dart';
import 'file_reader_service.dart';
import 'package:flutter/services.dart';

abstract class FileReaderService {
  Future<Uint8List> read(String path);
}

class FileReaderServiceMobile implements FileReaderService {
  @override
  Future<Uint8List> read(String path) async {
    final file = io.File(path);

    return await file.readAsBytes();
  }
}

class FileReaderServiceWeb implements FileReaderService {
  @override
  Future<Uint8List> read(String path) async {
    final blob = Blob([path]);
    final reader = FileReader();

    final completer = Completer<Uint8List>();
    reader.onLoadEnd.listen((event) {
      completer.complete(reader.result as Uint8List);
    });
    reader.onError.listen((event) {
      completer.completeError(event);
    });
    reader.readAsArrayBuffer(blob);

    return completer.future;
  }
}
