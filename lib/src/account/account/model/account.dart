import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String uid;
  final String email;
  final bool isSeller;

  Account({required this.uid, required this.email, required this.isSeller});

  factory Account.fromDocument(DocumentSnapshot doc) {
    return Account(
      uid: doc.id,
      email: doc['email'],
      isSeller: doc['isSeller'],
    );
  }
}
