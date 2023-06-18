import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repositories/models/delivery_method.dart';
import 'package:repositories/repositories.dart';

part 'product_detail_state.dart';

class ViewProductDetailsCubit extends Cubit<ViewProductDetailsState> {
  final ProductDetailsRepository productDetailsRepository;
  final AuthenticationRepository authenticationRepository;
  ViewProductDetailsCubit({
    required this.productDetailsRepository,
    required this.authenticationRepository,
  }) : super(const ViewProductDetailsState());

  Future<void> getProductDetails() async {
    emit(state.copyWith(status: ViewProductDetailsStatus.loading));
    try {
      var productDetails = await productDetailsRepository.get();
      addModifiersToState(productDetails.modifiers);
      emit(state.copyWith(
          productDetails: productDetails,
          status: ViewProductDetailsStatus.success));
    } on FetchProductFailure catch (e) {
      emit(state.copyWith(
          status: ViewProductDetailsStatus.failure, errorMessage: e.message));
    }
  }

  void addModifiersToState(List<CartModifier>? cartModifierSelections) {
    List<CartModifierSelection> translated = [];
    for (CartModifier mod in cartModifierSelections ?? []) {
      if (mod is CartTextModifier) {
        translated.add(CartTextModifierSelection(
          id: mod.id,
          required: mod.required,
        ));
      } else {
        translated.add(CartMultiChoiceModifierSelection(
          id: mod.id,
          required: mod.required,
        ));
      }
    }

    emit(state.copyWith(cartModifierSelections: translated));
  }

  void multiChoiceModifierSelectionChanged(int index, String value) {
    if (state.cartModifierSelections == null) return;

    final mods = state.cartModifierSelections!;

    mods[index] = (mods[index] as CartMultiChoiceModifierSelection)
        .copyWith(choiceId: value);

    final priceToAdd =
        (state.productDetails!.modifiers![index] as CartMultiChoiceModifier)
            .choices!
            .where((element) => element.id == value)
            .first
            .price;

    print("price to Add $priceToAdd");

    final totalPrice =
        state.productDetails!.price + (double.tryParse(priceToAdd) ?? 0);

    print("total price $totalPrice");
    emit(state.copyWith(
        displayPrice: totalPrice.toString(),
        cartModifierSelections: mods,
        inputStatus: _computeStatus(mods)));
  }

  void textModifierSelectionChanged(int index, String value) {
    if (state.cartModifierSelections == null) return;

    final mods = state.cartModifierSelections!;
    var characterLimit = int.tryParse(
        (state.productDetails!.modifiers![index] as CartTextModifier)
            .characterLimit);

    var priceToAdd =
        (state.productDetails!.modifiers![index] as CartTextModifier).price;
    var totalPrice;
    if (!(totalPrice == "" || totalPrice == "0")) {
      totalPrice =
          state.productDetails!.price + (double.tryParse(priceToAdd) ?? 0);
    }

    final textInput = CartTextModifierInput.dirty(
      value: value,
      characterLimit: characterLimit,
      required: mods[index].required,
    );

    mods[index] = (mods[index] as CartTextModifierSelection)
        .copyWith(cartTextModifierInput: textInput);

    emit(state.copyWith(
        cartModifierSelections: mods, inputStatus: _computeStatus(mods)));
  }

  FormzStatus _computeStatus(List<CartModifierSelection> selections) {
    if (selections.isEmpty) return FormzStatus.valid;
    for (CartModifierSelection mod in selections) {
      if (mod is CartTextModifierSelection) {
        if (mod.required) {
          if (mod.cartTextModifierInput.value == "" ||
              !mod.cartTextModifierInput.valid) {
            return FormzStatus.invalid;
          }
        } else {
          if (mod.cartTextModifierInput.value != "" &&
              !mod.cartTextModifierInput.valid) {
            return FormzStatus.invalid;
          }
        }
      } else if (mod is CartMultiChoiceModifierSelection) {
        if (mod.required && mod.choiceId == '') {
          return FormzStatus.invalid;
        }
      }
    }

    return FormzStatus.valid;
  }
}
