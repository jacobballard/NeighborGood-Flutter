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
    print('getting product details');
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
    if (cartModifierSelections == null || cartModifierSelections.isEmpty) {
      emit(state.copyWith(inputStatus: FormzStatus.valid));
    }
    for (CartModifier mod in cartModifierSelections ?? []) {
      if (mod is CartTextModifier) {
        translated.add(CartTextModifierSelection(
          price: mod.price,
          id: mod.id,
          required: mod.required,
          question: "",
          answer: "",
        ));
      } else if (mod is CartMultiChoiceModifier) {
        translated.add(CartMultiChoiceModifierSelection(
          price: null,
          id: mod.id,
          required: mod.required,
          question: "",
          answer: "",
        ));
      }
    }

    emit(state.copyWith(cartModifierSelections: translated));
  }

  void setProductDetails(ProductDetails details) {
    emit(state.copyWith(productDetails: details));
  }

  void _computePrice() {
    var totalPrice = state.productDetails!.price;

    for (CartModifierSelection mod in state.cartModifierSelections ?? []) {
      if (mod is CartMultiChoiceModifierSelection) {
        if (mod.price != null && mod.price!.isNotEmpty) {
          totalPrice += double.tryParse(mod.price!) ?? 0.0;
        }
      } else if (mod is CartTextModifierSelection) {
        if (mod.price != null &&
            mod.price!.isNotEmpty &&
            mod.cartTextModifierInput.valid &&
            mod.cartTextModifierInput.value.isNotEmpty) {
          totalPrice += double.tryParse(mod.price!) ?? 0.0;
        }
      }
    }

    String displayPrice = totalPrice
        .toStringAsFixed(2); // Convert to String with 2 decimal places
    emit(state.copyWith(displayPrice: displayPrice));
  }

  void multiChoiceModifierSelectionChanged(int index, String value) {
    if (state.cartModifierSelections == null) return;

    final mods = state.cartModifierSelections!;

    CartChoice choice =
        (state.productDetails!.modifiers![index] as CartMultiChoiceModifier)
            .choices!
            .where((element) => element.id == value)
            .first;

    final priceToAdd = choice.price;

    final choiceAnswer = choice.title;

    final choiceQuestion =
        (state.productDetails!.modifiers![index] as CartMultiChoiceModifier)
            .title;

    mods[index] = (mods[index] as CartMultiChoiceModifierSelection).copyWith(
      choiceId: value,
      price: priceToAdd,
      question: choiceQuestion,
      answer: choiceAnswer,
    );

    emit(state.copyWith(
        cartModifierSelections: mods, inputStatus: _computeStatus(mods)));

    _computePrice();
  }

  void textModifierSelectionChanged(int index, String value) {
    if (state.cartModifierSelections == null) return;

    final mods = state.cartModifierSelections!;
    var characterLimit = int.tryParse(
        (state.productDetails!.modifiers![index] as CartTextModifier)
            .characterLimit);

    CartTextModifier textModifier =
        state.productDetails!.modifiers![index] as CartTextModifier;

    var priceToAdd = textModifier.price;

    final question = textModifier.title;

    // final answer =
    // var totalPrice;
    // if (!(totalPrice == "" || totalPrice == "0")) {
    //   totalPrice =
    //       state.productDetails!.price + (double.tryParse(priceToAdd) ?? 0);
    // }

    final textInput = CartTextModifierInput.dirty(
      value: value,
      characterLimit: characterLimit,
      required: mods[index].required,
    );

    mods[index] = (mods[index] as CartTextModifierSelection).copyWith(
        cartTextModifierInput: textInput,
        price: priceToAdd,
        question: question,
        answer: textInput.value);

    emit(state.copyWith(
        cartModifierSelections: mods, inputStatus: _computeStatus(mods)));

    _computePrice();
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
