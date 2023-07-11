import 'package:cloud_firestore/cloud_firestore.dart';

class StoreDetail {
  final String storeId;
  final String storeName;
  final String description;
  final List<String> imageUrls;

  const StoreDetail({
    required this.storeId,
    required this.storeName,
    required this.description,
    required this.imageUrls,
  });

  factory StoreDetail.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return StoreDetail(
      storeId: doc.id,
      storeName: data['store_name'] ?? '',
      description: data['description'] ?? '',
      imageUrls:
          (data['image_urls'] as List).map((item) => item as String).toList(),
    );
  }

  StoreDetail copyWith({
    String? storeId,
    String? storeName,
    String? description,
    List<String>? imageUrls,
  }) {
    return StoreDetail(
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
