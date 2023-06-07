import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepository {
  ProfileRepository(
      {required this.userId, required this.authenticationRepository})
      : _userDocument = userId != null
            ? FirebaseFirestore.instance.collection('users').doc(userId)
            : null;
  // _firebaseStorage = FirebaseStorage.instance;

  final DocumentReference<Map<String, dynamic>>? _userDocument;
  // final FirebaseStorage _firebaseStorage;
  final AuthenticationRepository authenticationRepository;
  final String? userId;

  // Stream<User> get user {
  //   print(userId);
  //   print("id");
  //   if (_userDocument != null) {
  //     return _userDocument!.snapshots().map((snapshot) {
  //       final data = snapshot.data();
  //       return data != null ? User.fromDocument(snapshot) : User.empty;
  //     });
  //   } else {
  //     // Return a stream that only emits User.empty
  //     return Stream<User>.value(User.empty);
  //   }
  // }
  Stream<User> get user {
    print(userId);
    print("id");
    if (_userDocument != null) {
      return _userDocument!.snapshots().map((snapshot) {
        final data = snapshot.data();
        return data != null ? User.fromDocument(snapshot) : User.empty;
      }).handleError((error, stackTrace) {
        // If an error occurs, wait for a delay and then retry.
        print("retry");
        return Future.delayed(Duration(seconds: 3), () => user);
      });
    } else {
      // Return a stream that only emits User.empty
      return Stream<User>.value(User.empty);
    }
  }
  // Future<void> createStore({
  //   required String id,
  //   required String title,
  //   String? description,
  //   String? insta,
  //   String? tik,
  //   String? meta,
  //   String? pin,
  // }) async {
  //   if (title.isEmpty) {
  //     throw Exception('Title is required');
  //   }

  //   try {
  //     final WriteBatch batch = FirebaseFirestore.instance.batch();

  //     final storeDocRef =
  //         FirebaseFirestore.instance.collection('stores').doc(id);

  //     final userDocRef = FirebaseFirestore.instance.collection('users').doc(id);

  //     batch.set(storeDocRef, {
  //       'title': title,
  //       if (description != null && description.isNotEmpty)
  //         'description': description,
  //       if (insta != null && insta.isNotEmpty) 'insta': insta,
  //       if (tik != null && tik.isNotEmpty) 'tik': tik,
  //       if (meta != null && meta.isNotEmpty) 'meta': meta,
  //       if (pin != null && pin.isNotEmpty) 'pin': pin,
  //     });

  //     batch.update(userDocRef, {'accountType': 'seller'});

  //     await batch.commit();
  //   } catch (e) {
  //     throw Exception('Failed to create store: ${e.toString()}');
  //   }
  // }

  // Future<void> updateUser(User user) async {
  //   if (user.isEmpty) {
  //     throw Exception('Cannot update empty user');
  //   }

  //   try {
  //     // Upload the image to Firebase Storage and get the download URL, if a new image is provided
  //     String? photoUrl;
  //     if (user.photo != null && user.photo!.isNotEmpty) {
  //       final ref = _firebaseStorage.ref('user_photos/${user.id}');
  //       final uploadTask =
  //           ref.putString(user.photo!, format: PutStringFormat.dataUrl);
  //       await uploadTask;
  //       photoUrl = await ref.getDownloadURL();
  //     }

  //     // Update the user document in Firestore
  //     await _userDocument.set(
  //       {
  //         ...user.copyWith(photo: photoUrl).toMap(),
  //       },
  //       SetOptions(merge: true),
  //     );
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Error updating user information');
  //   }
  // }
}
