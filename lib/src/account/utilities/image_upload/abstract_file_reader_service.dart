import 'package:pastry/src/account/utilities/image_upload/web_file_reader.dart';

import 'dart:typed_data';

abstract class FileReaderService {
  Future<Uint8List> read(String path);

  factory FileReaderService() => getFileReader();
}
