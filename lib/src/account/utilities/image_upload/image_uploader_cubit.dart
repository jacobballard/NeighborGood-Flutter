import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'image_uploader_repository.dart';

enum ImageUploaderStatus { initial, uploading, success, failure }

class ImageUploaderState extends Equatable {
  const ImageUploaderState({
    this.uploadStatus = ImageUploaderStatus.initial,
    this.imageUrls = const <String>[],
    this.status = FormzStatus.valid,
    this.errorMessage,
  });

  final ImageUploaderStatus uploadStatus;
  final List<String> imageUrls;
  final FormzStatus status;
  final String? errorMessage;

  ImageUploaderState copyWith({
    ImageUploaderStatus? uploadStatus,
    List<String>? imageUrls,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ImageUploaderState(
      uploadStatus: uploadStatus ?? this.uploadStatus,
      imageUrls: imageUrls ?? this.imageUrls,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        uploadStatus,
        imageUrls,
        status,
      ];
}

class ImageUploaderCubit extends Cubit<ImageUploaderState> {
  ImageUploaderCubit({
    required this.imageUploaderRepository,
  }) : super(const ImageUploaderState());

  final ImageUploaderRepository imageUploaderRepository;

  // final AuthenticationRepository authRepo;

  Future<void> pickAndUploadImage() async {
    try {
      emit(state.copyWith(uploadStatus: ImageUploaderStatus.uploading));

      final List<String> urls =
          await imageUploaderRepository.pickAndUploadImage();
      emit(state.copyWith(
          uploadStatus: ImageUploaderStatus.success,
          imageUrls: [...state.imageUrls, ...urls],
          status: FormzStatus.valid));
    } on Exception {
      emit(state.copyWith(
        uploadStatus: ImageUploaderStatus.failure,
        status: state.uploadStatus == ImageUploaderStatus.success
            ? FormzStatus.valid
            : FormzStatus.invalid,
      ));
    }
  }

  Future<void> reorderImages(int oldIndex, int newIndex) async {
    List<String> orderedUrls = List.from(state.imageUrls);
    String movedImage = orderedUrls.removeAt(oldIndex);
    orderedUrls.insert(newIndex, movedImage);
    try {
      imageUploaderRepository.reorderImageUrls(orderedUrls);
      emit(state.copyWith(
        imageUrls: orderedUrls,
        status: FormzStatus.valid,
        uploadStatus: ImageUploaderStatus.success,
      ));
    } on ImageUploadException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        uploadStatus: ImageUploaderStatus.failure,
      ));
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      await imageUploaderRepository.deleteImageUrl(imageUrl);
      List<String> updatedImageUrls = List.from(state.imageUrls);
      updatedImageUrls.remove(imageUrl);
      emit(state.copyWith(
          imageUrls: updatedImageUrls,
          uploadStatus: ImageUploaderStatus.success));
    } on ImageUploadException catch (e) {
      print(e.message);
      emit(state.copyWith(
        errorMessage: e.message,
        uploadStatus: ImageUploaderStatus.failure,
      ));
    }
  }
}
