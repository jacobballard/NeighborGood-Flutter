import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:pastry/src/product/detail/model/product.dart';

part 'product_upload_event.dart';
part 'product_upload_state.dart';

class ProductUploadBloc extends Bloc<ProductUploadEvent, ProductUploadState> {
  ProductUploadBloc() : super(ProductUploadInitial()) {
    on<ProductUpload>(_onProductUpload);
  }

  Future<void> _onProductUpload(
    ProductUpload event,
    Emitter<ProductUploadState> emit,
  ) async {
    emit(ProductUploadInProgress());
    try {
      // 1. Handle image selection/upload
      List<File> imageFiles = [];
      if (kIsWeb) {
        // Web: File Picker
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: true,
        );
        if (result != null) {
          imageFiles = result.paths.map((path) => File(path!)).toList();
        }
      } else {
        // Mobile: Image Picker and Camera
        final ImagePicker picker = ImagePicker();

        XFile? file = await picker.pickImage(source: event.imageSource);
        if (file != null) {
          imageFiles.add(File(file.path));
        }
      }

      // 2. Upload product images and details
      if (imageFiles.isNotEmpty) {
        // You can replace the following line with your existing createStore function call
        // await createStore(store, imageFiles);
        await uploadProduct(event.product, imageFiles);
      }

      emit(ProductUploadSuccess());
    } catch (error) {
      emit(ProductUploadFailure(error: error.toString()));
    }
  }

  Future<void> uploadProduct(Product product, List<File> imageFiles) async {
    // Implement product upload logic here
    // 1. Upload images to Firebase Storage or another storage service
    // 2. Save the product information to Firestore or another database service
  }
}
