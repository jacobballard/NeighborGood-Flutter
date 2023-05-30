import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'image_uploader_repository.dart';

enum ImageUploaderStatus { initial, uploading, success, failure }

class ImageUploaderState extends Equatable {
  const ImageUploaderState(
      {this.uploadStatus = ImageUploaderStatus.initial,
      this.imageUrls = const <String>[],
      this.status = FormzStatus.valid});

  final ImageUploaderStatus uploadStatus;
  final List<String> imageUrls;
  final FormzStatus status;

  ImageUploaderState copyWith(
      {ImageUploaderStatus? uploadStatus,
      List<String>? imageUrls,
      FormzStatus? status}) {
    return ImageUploaderState(
        uploadStatus: uploadStatus ?? this.uploadStatus,
        imageUrls: imageUrls ?? this.imageUrls,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [uploadStatus, imageUrls, status];
}

class ImageUploaderCubit extends Cubit<ImageUploaderState> {
  ImageUploaderCubit(this._imageUploaderRepository)
      : super(const ImageUploaderState());

  final ImageUploaderRepository _imageUploaderRepository;
  // final AuthenticationRepository authRepo;

  Future<void> pickAndUploadImage() async {
    try {
      print("here");
      emit(state.copyWith(uploadStatus: ImageUploaderStatus.uploading));
      // TODO : pass auth uid
      final List<String> urls =
          await _imageUploaderRepository.pickAndUploadImage("");
      emit(state.copyWith(
          uploadStatus: ImageUploaderStatus.success,
          imageUrls: [...state.imageUrls, ...urls],
          status: FormzStatus.valid));
    } on Exception {
      emit(state.copyWith(
          uploadStatus: ImageUploaderStatus.failure,
          status: FormzStatus.valid));
    }
  }
}
