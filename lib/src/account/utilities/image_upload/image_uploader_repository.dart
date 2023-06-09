import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import 'abstract_file_reader_service.dart';

abstract class ImageUploaderRepository {
  final FileReaderService fileReaderService;

  ImageUploaderRepository(this.fileReaderService);
  Future<List<String>> pickAndUploadImage();
  Future<void> reorderImageUrls(List<String> orderedUrls);
  Future<void> deleteImageUrl(String imageUrl);
}

class ConcreteImageUploaderRepository extends ImageUploaderRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final String firestorePath;
  ConcreteImageUploaderRepository(
      {required FileReaderService fileReaderService,
      required String uploadPath})
      : firestorePath = uploadPath,
        super(fileReaderService);

  Future<Uint8List> readBytes(String path, XFile file) async {
    return fileReaderService.read(path, file);
  }

  @override
  Future<List<String>> pickAndUploadImage() async {
    List<String> downloadUrls = [];
    print("we're here");
    print(firestorePath);
    try {
      final pickedFiles = await _picker.pickMultiImage();

      print("picked");
      // First, upload each file to Firebase Storage and collect the download URLs.
      for (var file in pickedFiles) {
        print(file.path);
        Uint8List data = await readBytes(file.path, file);

        print("success");
        var snapshot = await _storage
            .ref('$firestorePath/${path.basename(file.path)}')
            .putData(data);

        print("next");
        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        downloadUrls.add(downloadUrl);
      }
      print("done loops");
      // Second, get the Firestore document at the given path.
      DocumentReference docRef;

      if (firestorePath.contains("stores")) {
        docRef = FirebaseFirestore.instance.doc(firestorePath);
      } else {
        // Split the path into segments
        var subpath = firestorePath.substring(1);
        List<String> pathSegments = subpath.split('/');

// Create a reference using the segments
        CollectionReference ref =
            FirebaseFirestore.instance.collection("users");
        docRef = ref
            .doc(pathSegments[1])
            .collection(pathSegments[0])
            .doc(pathSegments[2]);
      }
      DocumentSnapshot docSnapshot = await docRef.get();

      // If the document exists, update it. Otherwise, create a new document with the image URLs.
      if (docSnapshot.exists) {
        await docRef
            .update({'image_urls': FieldValue.arrayUnion(downloadUrls)});
      } else {
        await docRef.set({'image_urls': downloadUrls});
      }
    } catch (e) {
      print(e);
      throw ImageUploadException('Failed to upload images: $e');
    }
    return downloadUrls;
  }

  @override
  Future<void> reorderImageUrls(List<String> orderedUrls) async {
    try {
      DocumentReference docRef;

      if (firestorePath.contains("stores")) {
        docRef = FirebaseFirestore.instance.doc(firestorePath);
      } else {
        // Split the path into segments
        var subpath = firestorePath.substring(1);
        List<String> pathSegments = subpath.split('/');

// Create a reference using the segments
        CollectionReference ref =
            FirebaseFirestore.instance.collection("users");
        docRef = ref
            .doc(pathSegments[1])
            .collection(pathSegments[0])
            .doc(pathSegments[2]);
      }
      await docRef.update({'image_urls': orderedUrls});
    } catch (e) {
      throw ImageUploadException('Failed to reorder image URLs: $e');
    }
  }

  @override
  Future<void> deleteImageUrl(String imageUrl) async {
    try {
      // Get the Firestore document at the given path.

      DocumentReference docRef;

      if (firestorePath.contains("stores")) {
        docRef = FirebaseFirestore.instance.doc(firestorePath);
      } else {
        // Split the path into segments
        var subpath = firestorePath.substring(1);
        List<String> pathSegments = subpath.split('/');

// Create a reference using the segments
        CollectionReference ref =
            FirebaseFirestore.instance.collection("users");
        docRef = ref
            .doc(pathSegments[1])
            .collection(pathSegments[0])
            .doc(pathSegments[2]);
      }
      await docRef.update({
        'image_urls': FieldValue.arrayRemove([imageUrl])
      });
      print("updated");
      // Construct the image's storage path from the imageUrl.
      // Uri imageUrlUri = Uri.parse(imageUrl);
      // String imageStoragePath = imageUrlUri.path;

      // print(imageUrl);
      // print(imageUrlUri.toString());
      // print(imageStoragePath);

      Uri imageUrlUri = Uri.parse(imageUrl);
      String imageStoragePath = imageUrlUri.path.split('/o/').last;
      imageStoragePath = Uri.decodeFull(imageStoragePath);

      // Delete the image from Firebase Storage.
      await _storage.ref(imageStoragePath).delete();
    } catch (e) {
      throw ImageUploadException('Failed to delete image URL: $e');
    }
  }
}

class ImageUploadException implements Exception {
  final String message;
  ImageUploadException(this.message);
}
