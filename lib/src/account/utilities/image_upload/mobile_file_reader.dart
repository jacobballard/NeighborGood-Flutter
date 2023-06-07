import 'dart:typed_data';
import 'dart:io' as io;

import 'abstract_file_reader_service.dart';

class FileReaderServiceMobile implements FileReaderService {
  @override
  Future<Uint8List> read(String path) async {
    final file = io.File(path);

    return await file.readAsBytes();
  }
}

FileReaderService getFileReader() => FileReaderServiceMobile();
