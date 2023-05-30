import 'dart:async';
import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/services.dart' show rootBundle;

import 'file_reader_service.dart';

abstract class ImageUploaderRepository {
  final FileReaderService fileReaderService;

  ImageUploaderRepository(this.fileReaderService);
  Future<List<String>> pickAndUploadImage(String userId);
}

class ProductImageUploaderRepository extends ImageUploaderRepository {
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  ProductImageUploaderRepository(FileReaderService fileReaderService)
      : super(fileReaderService);

  Future<Uint8List> readBytes(String path) async {
    return fileReaderService.read(path);
  }

  @override
  Future<List<String>> pickAndUploadImage(String userId) async {
    final pickedFiles = await _picker.pickMultiImage();

    List<String> downloadUrls = [];

    for (var file in pickedFiles) {
      Uint8List data = await readBytes(file.path);
      // var snapshot = await _storage
      //     .ref('$userId/products/${Path.basename(file.path)}')
      //     .putData(data);

      // var downloadUrl = await snapshot.ref.getDownloadURL();
      // downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }
}

class StoreImageUploaderRepository extends ImageUploaderRepository {
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  StoreImageUploaderRepository(FileReaderService fileReaderService)
      : super(fileReaderService);

  Future<Uint8List> readBytes(String path) async {
    return fileReaderService.read(path);
  }

  @override
  Future<List<String>> pickAndUploadImage(String userId) async {
    final pickedFiles = await _picker.pickMultiImage();

    List<String> downloadUrls = [];

    for (var file in pickedFiles) {
      Uint8List data = await readBytes(file.path);
      // var snapshot = await _storage
      //     .ref('$userId/store/${Path.basename(file.path)}')
      //     .putData(data);

      // var downloadUrl = await snapshot.ref.getDownloadURL();
      // downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }
}
