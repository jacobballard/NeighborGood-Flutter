import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repositories/models/delivery_method.dart';

class GetDeliveryMethodsRepository {
  final String sellerId;

  GetDeliveryMethodsRepository({required this.sellerId});

  Future<List<DeliveryMethod>> get() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('stores')
        .doc(sellerId)
        .get();

    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    List<dynamic> dmList = data['delivery_methods'] as List<dynamic>;

    return dmList
        .map(
            (dmJson) => DeliveryMethod.fromJson(dmJson as Map<String, dynamic>))
        .toList();
  }
}
