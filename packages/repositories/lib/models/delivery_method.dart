import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';

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

  factory DeliveryMethod.fromJson(Map<String, dynamic> json) {
    return DeliveryMethod(
      type: stringToEnum(json['type']),
      range: DeliveryRange.dirty(json['range']),
      fee: DeliveryFee.dirty(json['fee']),
      eta: Eta.dirty(json['eta']),
      showAddress: json['showAddress'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    print("to json");

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = enumToString(this.type);
    data['range'] = this.range.value;
    data['fee'] = this.fee.value;
    data['eta'] = this.eta.value;
    data['showAddress'] = this.showAddress;
    print(data);
    return data;
  }
}

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
