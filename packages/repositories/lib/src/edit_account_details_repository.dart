import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditAccountDetailsRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateDisplayName(String displayName) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(displayName);
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'displayName': displayName});
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    User? user = _auth.currentUser;
    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } else {
      throw Exception('User not found');
    }
  }
}
