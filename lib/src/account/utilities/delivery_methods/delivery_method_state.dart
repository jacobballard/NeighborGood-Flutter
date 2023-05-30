part of 'delivery_method_cubit.dart';

// ignore: constant_identifier_names
enum DeliveryMethodType { none, local_pickup, delivery, shipping }

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

class DeliveryMethod extends Equatable {
  final DeliveryMethodType type;
  final DeliveryRange range;
  final DeliveryFee fee;
  final Eta eta;
  final bool showAddress;

  DeliveryMethod(
      {required this.type,
      this.range = const DeliveryRange.pure(),
      this.fee = const DeliveryFee.pure(),
      this.eta = const Eta.pure(),
      this.showAddress = true});

  @override
  List<Object> get props => [type, range, fee, eta, showAddress];

  // Add this
  DeliveryMethod copyWith({
    DeliveryMethodType? type,
    DeliveryRange? range,
    DeliveryFee? fee,
    Eta? eta,
    bool? showAddress,
  }) {
    return DeliveryMethod(
        type: type ?? this.type,
        range: range ?? this.range,
        fee: fee ?? this.fee,
        eta: eta ?? this.eta,
        showAddress: showAddress ?? this.showAddress);
  }
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
