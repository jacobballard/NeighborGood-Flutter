part of 'delivery_method_cubit.dart';

// ignore: constant_identifier_names

String enumToString(DeliveryMethodType methodType) {
  String result = methodType.toString().split('.').last;
  result = result.replaceAll('_', ' ');
  result = '${result[0].toUpperCase()}${result.substring(1)}';
  return result;
}

DeliveryMethodType stringToEnum(String methodTypeString) {
  return DeliveryMethodType.values.firstWhere(
    (element) => enumToString(element) == methodTypeString,
    orElse: () => DeliveryMethodType.none,
  );
}

class DeliveryMethodsState {
  final List<DeliveryMethod> methods;
  final FormzStatus status;

  DeliveryMethodsState({
    this.methods = const [],
    this.status = FormzStatus.pure,
  });

  DeliveryMethodsState copyWith({
    List<DeliveryMethod>? methods,
    FormzStatus? status,
  }) {
    return DeliveryMethodsState(
      methods: methods ?? this.methods,
      status: status ?? this.status,
    );
  }
}
