import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  String userID;
  String storeName;
  String description;
  Coordinates coordinates;
  Socials socials;

  Store({
    required this.userID,
    required this.storeName,
    required this.description,
    required this.coordinates,
    required this.socials,
  });

  factory Store.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Store(
      userID: doc.id,
      storeName: data['storeName'],
      description: data['description'],
      coordinates: Coordinates.fromMap(data['coordinates']),
      socials: Socials.fromMap(data['socials']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'description': description,
      'coordinates': coordinates.toMap(),
      'socials': socials.toMap(),
    };
  }
}

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({required this.latitude, required this.longitude});

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'latitude': latitude, 'longitude': longitude};
  }
}

class Socials {
  String tiktok;
  String meta;
  String instagram;
  String pinterest;

  Socials(
      {required this.tiktok,
      required this.meta,
      required this.instagram,
      required this.pinterest});

  factory Socials.fromMap(Map<String, dynamic> map) {
    return Socials(
      tiktok: map['tiktok'],
      meta: map['meta'],
      instagram: map['instagram'],
      pinterest: map['pinterest'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tiktok': tiktok,
      'meta': meta,
      'instagram': instagram,
      'pinterest': pinterest,
    };
  }
}
