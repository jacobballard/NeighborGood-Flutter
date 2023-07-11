import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/models/store_detail.dart';
import 'package:repositories/repositories.dart';

part 'store_detail_state.dart';

class StoreDetailCubit extends Cubit<StoreDetailState> {
  final StoreDetailsRepository storeDetailsRepository;
  final AuthenticationRepository authenticationRepository;

  StoreDetailCubit({
    required this.storeDetailsRepository,
    required this.authenticationRepository,
  }) : super(const StoreDetailState());

  Future<void> getStoreDetails() async {
    emit(state.copyWith(status: StoreDetailStatus.loading));
    try {
      var storeDetails = await storeDetailsRepository.get();

      emit(state.copyWith(
        store: storeDetails,
        status: StoreDetailStatus.success,
      ));
    } on FetchStoreFailure catch (e) {
      emit(state.copyWith(
          status: StoreDetailStatus.failure, errorMessage: e.message));
    }
  }

  // Future<void> getProductDetails() async {
  //   emit(state.copyWith(productsStatus: StoreProductDetailStatus.loading));

  //   try {
  //     var products = await storeDetailsRepository.getProducts();

  //     emit(state.copyWith(
  //         products: products,
  //         productsStatus: StoreProductDetailStatus.success));
  //   } on FetchProductFailure catch (e) {
  //     emit(state.copyWith(
  //         status: StoreDetailStatus.failure, errorMessage: e.message));
  //   }
  // }
}
