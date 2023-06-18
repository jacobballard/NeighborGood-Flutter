import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:repositories/models/delivery_method.dart';
import 'package:repositories/repositories.dart';

part 'delivery_method_state.dart';

class DeliveryMethodsCubit extends Cubit<DeliveryMethodsState> {
  final GetDeliveryMethodsRepository? getDeliveryMethodsRepository;
  DeliveryMethodsCubit(
      {this.required = true, required this.getDeliveryMethodsRepository})
      : super(DeliveryMethodsState());

  final bool required;

  List<String> get availableMethods {
    final selectedMethods = state.methods.map((method) => method.type);
    return ['local pickup', 'delivery', 'shipping']
        // ignore: iterable_contains_unrelated_type
        .where((method) => !selectedMethods.contains(method))
        .toList();
  }

  void addMethod() {
    var newMethod = DeliveryMethod(
      type: DeliveryMethodType.none,
      range: const DeliveryRange.dirty(''),
      fee: const DeliveryFee.dirty(''),
      eta: const Eta.dirty(''),
    );
    var methods = List<DeliveryMethod>.from(state.methods)..add(newMethod);
    emit(state.copyWith(
      methods: methods,
      status: _computeStatus(methods),
    ));
  }

  Future<void> loadMethods() async {
    List<DeliveryMethod> methods = await getDeliveryMethodsRepository!.get();
    emit(state.copyWith(methods: methods));
  }

  void removeMethod(int index) {
    final methods = state.methods;
    methods.removeAt(index);
    emit(state.copyWith(
      methods: List.from(methods),
      status: _computeStatus(methods),
    ));
  }

  void changeMethodType(int index, DeliveryMethodType newMethodType) {
    final methods = state.methods;
    methods[index] = methods[index].copyWith(type: newMethodType);
    emit(state.copyWith(
      methods: List.from(methods),
      status: _computeStatus(methods),
    ));
  }

  List<DeliveryMethodType> getRemainingMethods() {
    List<DeliveryMethodType> remainingMethods =
        DeliveryMethodType.values.toList();
    for (var method in state.methods) {
      remainingMethods.remove(method.type);
    }
    return remainingMethods;
  }

  void changeRange(int index, String range) {
    final methods = state.methods;
    final rangeInput = DeliveryRange.dirty(range);
    methods[index] = methods[index].copyWith(range: rangeInput);
    emit(state.copyWith(
        methods: List.from(methods), status: _computeStatus(methods)));
  }

  void changeFee(int index, String fee) {
    final methods = state.methods;
    final feeInput = DeliveryFee.dirty(fee);
    methods[index] = methods[index].copyWith(fee: feeInput);
    emit(state.copyWith(
        methods: List.from(methods), status: _computeStatus(methods)));
  }

  void changeEta(int index, String eta) {
    final methods = state.methods;
    final etaInput = Eta.dirty(eta);
    methods[index] = methods[index].copyWith(eta: etaInput);
    emit(state.copyWith(
        methods: List.from(methods), status: _computeStatus(methods)));
  }

  bool? changeShowAddress(int index) {
    if (state.methods[index].type == DeliveryMethodType.local_pickup) {
      final methods = state.methods;
      methods[index] =
          methods[index].copyWith(showAddress: !methods[index].showAddress);

      emit(state.copyWith(
          methods: List.from(methods), status: _computeStatus(methods)));
      return methods[index].showAddress;
    }
    return null;
  }

  FormzStatus _computeStatus(List<DeliveryMethod> methods) {
    if (methods.isEmpty) {
      return required ? FormzStatus.invalid : FormzStatus.valid;
    }
    for (var method in methods) {
      switch (method.type) {
        case DeliveryMethodType.delivery:
          if (!method.range.valid && method.range.value != "") {
            return FormzStatus.invalid;
          }
          if (!method.fee.valid && method.fee.value != "") {
            return FormzStatus.invalid;
          }
          if (!method.eta.valid && method.eta.value != "") {
            return FormzStatus.invalid;
          }
          // if (!(method.range.valid && method.fee.valid && method.eta.valid) &&
          //     !(method.range.value == "" &&
          //         method.fee.value == "" &&
          //         method.eta.value == "")) {
          //   print("Oh no :()");
          //   return FormzStatus.invalid;
          // } else {
          //   print("yay");
          //   break;
          // }

          break;
        case DeliveryMethodType.local_pickup:
          if (!method.eta.valid && method.eta.value != "") {
            return FormzStatus.invalid;
          } else {
            break;
          }
        case DeliveryMethodType.shipping:
          if (!method.fee.valid && method.fee.value != "") {
            return FormzStatus.invalid;
          }

          if (!method.eta.valid && method.eta.value != "") {
            return FormzStatus.invalid;
          }
          // if (!(method.fee.valid && method.eta.valid) ||
          //     !(method.fee.value == "" && method.eta.value == "")) {
          //   return FormzStatus.invalid;
          // } else {
          //   break;
          // }
          break;
        case DeliveryMethodType.none:
          if (methods.length == 2 && methods[0].type == methods[1].type) {
            return FormzStatus.invalid;
          } else if (methods.length == 3 &&
              (methods[0].type == methods[1].type &&
                  methods[1].type == methods[2].type &&
                  methods[2].type == methods[0].type)) {
            return FormzStatus.invalid;
          } else if (methods.length == 1) {
            return FormzStatus.invalid;
          } else {
            break;
          }
      }
    }
    return FormzStatus.valid;
  }
}
