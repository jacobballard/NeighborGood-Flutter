import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepository {
  ProfileRepository({required String userId})
      : userId = userId,
        _userDocument =
            FirebaseFirestore.instance.collection('users').doc(userId),
        _firebaseStorage = FirebaseStorage.instance;

  final DocumentReference<Map<String, dynamic>> _userDocument;
  final FirebaseStorage _firebaseStorage;

  final String userId;

  Stream<User> get user {
    return _userDocument.snapshots().map((snapshot) {
      final data = snapshot.data();
      return data != null ? User.fromDocument(snapshot) : User.empty;
    });
  }

  Future<void> createStore({
    required String id,
    required String title,
    required String description,
    required String insta,
    required String tik,
    required String meta,
    required String pin,
  }) async {
    if (title.isEmpty) {
      throw Exception('Title is required');
    }

    try {
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      // Reference to the store document
      final storeDocRef =
          FirebaseFirestore.instance.collection('stores').doc(id);

      // Reference to the user document
      final userDocRef = FirebaseFirestore.instance.collection('users').doc(id);

      // Set store data
      batch.set(storeDocRef, {
        'title': title,
        if (description.isNotEmpty) 'description': description,
        if (insta.isNotEmpty) 'insta': insta,
        if (tik.isNotEmpty) 'tik': tik,
        if (meta.isNotEmpty) 'meta': meta,
        if (pin.isNotEmpty) 'pin': pin,
      });

      // Update user's accountType to seller
      batch.update(userDocRef, {'accountType': 'seller'});

      // Commit the batch
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to create store: ${e.toString()}');
    }
  }

  Future<void> updateUser(User user) async {
    if (user.isEmpty) {
      throw Exception('Cannot update empty user');
    }

    try {
      // Upload the image to Firebase Storage and get the download URL, if a new image is provided
      String? photoUrl;
      if (user.photo != null && user.photo!.isNotEmpty) {
        final ref = _firebaseStorage.ref('user_photos/${user.id}');
        final uploadTask =
            ref.putString(user.photo!, format: PutStringFormat.dataUrl);
        await uploadTask;
        photoUrl = await ref.getDownloadURL();
      }

      // Update the user document in Firestore
      await _userDocument.set(
        {
          ...user.copyWith(photo: photoUrl).toMap(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print(e);
      throw Exception('Error updating user information');
    }
  }
}