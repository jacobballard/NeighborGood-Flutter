import 'package:equatable/equatable.dart';
import 'package:repositories/models/delivery_method.dart';

class CartDeliveryMethod extends Equatable {
  final DeliveryMethodType type;
  final String fee;
  final String eta;

  CartDeliveryMethod({
    required this.type,
    required this.fee,
    required this.eta,
  });

  @override
  List<Object?> get props => [
        type,
        fee,
        eta,
      ];

  factory CartDeliveryMethod.fromJson(Map<String, dynamic> json) {
    return CartDeliveryMethod(
      type: stringToEnum(json['type']),
      fee: json['fee'] as String,
      eta: json['eta'] as String,
    );
  }
}
