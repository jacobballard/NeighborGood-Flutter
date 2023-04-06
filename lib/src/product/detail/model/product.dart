// class Product {
//   final String id;
//   final String bakerId;
//   final String bakerDisplayName;
//   final String name;
//   final String description;
//   final double price;
//   final List<String> imageUrls;

//   Product({
//     required this.bakerId,
//     required this.bakerDisplayName,
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.imageUrls,
//   });
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productID;
  String storeID;
  String productName;
  String? description;
  List<String>? ingredients;
  double basePrice;
  List<String>? tags;
  List<String> imageURLs;
  List<ShippingOption> shippingOptions;
  List<QuantityOption> quantityOptions;
  List<Modifier>? modifiers;

  Product({
    required this.productID,
    this.tags,
    this.ingredients,
    this.description,
    required this.storeID,
    required this.productName,
    required this.basePrice,
    required this.imageURLs,
    required this.shippingOptions,
    required this.quantityOptions,
    this.modifiers,
  });

  factory Product.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      productID: doc.id,
      storeID: data['storeID'],
      productName: data['productName'],
      description: data['description'],
      ingredients: data['ingredients'] != null
          ? List<String>.from(data['ingredients'])
          : null,
      basePrice: data['basePrice'].toDouble(),
      tags: data['tags'] != null ? List<String>.from(data['tags']) : null,
      imageURLs: List<String>.from(data['imageURLs']),
      shippingOptions: (data['shippingOptions'] as List)
          .map((option) => ShippingOption.fromMap(option))
          .toList(),
      quantityOptions: (data['quantityOptions'] as List)
          .map((option) => QuantityOption.fromMap(option))
          .toList(),
      modifiers: data['modifiers'] != null
          ? (data['modifiers'] as List)
              .map((modifier) => Modifier.fromMap(modifier))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeID': storeID,
      'productName': productName,
      'description': description,
      'ingredients': ingredients,
      'basePrice': basePrice,
      'tags': tags,
      'imageURLs': imageURLs,
      'shippingOptions':
          shippingOptions.map((option) => option.toMap()).toList(),
      'quantityOptions':
          quantityOptions.map((option) => option.toMap()).toList(),
      'modifiers': modifiers != null
          ? modifiers!.map((modifier) => modifier.toMap()).toList()
          : null,
    };
  }
}

enum ModifierType { picker, input }

class Modifier {
  String name;
  ModifierType type;
  List<String> options;
  bool allowMultiple;
  int? maxSelectable;
  String? defaultOption;

  Modifier({
    required this.name,
    required this.type,
    required this.options,
    required this.allowMultiple,
    this.maxSelectable,
    this.defaultOption,
  });

  factory Modifier.fromMap(Map<String, dynamic> map) {
    return Modifier(
      name: map['name'],
      type: ModifierType.values
          .firstWhere((e) => e.toString() == 'ModifierType.${map['type']}'),
      options: List<String>.from(map['options']),
      allowMultiple: map['allowMultiple'],
      maxSelectable: map['maxSelectable'],
      defaultOption: map['defaultOption'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'options': options,
      'allowMultiple': allowMultiple,
      'maxSelectable': maxSelectable,
      'defaultOption': defaultOption,
    };
  }
}

class ShippingOption {
  String optionName;
  double price;

  ShippingOption({required this.optionName, required this.price});

  factory ShippingOption.fromMap(Map<String, dynamic> map) {
    return ShippingOption(
      optionName: map['optionName'],
      price: map['price'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'optionName': optionName,
      'price': price,
    };
  }
}

class QuantityOption {
  String unit;
  double defaultValue;

  QuantityOption({required this.unit, required this.defaultValue});

  factory QuantityOption.fromMap(Map<String, dynamic> map) {
    return QuantityOption(
      unit: map['unit'],
      defaultValue: map['defaultValue'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'unit': unit,
      'defaultValue': defaultValue,
    };
  }
}
