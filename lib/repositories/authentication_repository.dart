import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

// Email Sign-up
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

// Email Login
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

// Google Sign-In
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    }
    throw Exception('Google Sign-In failed');
  }

// Facebook Login
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await _facebookAuth.login();
    if (result.status == LoginStatus.success) {
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      return await _firebaseAuth.signInWithCredential(credential);
    }
    throw Exception('Facebook Login failed');
  }

// Apple Sign-In
  Future<UserCredential> signInWithApple() async {
    if (await SignInWithApple.isAvailable()) {
      final AuthorizationCredentialAppleID result =
          await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final AuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    }
    throw Exception('Sign in with Apple is not available');
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuth.signInAnonymously();
  }

  Future<void> saveUserData({
    required String uid,
    required String fullName,
    required String username,
    required LatLng location,
    required String role,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'fullName': fullName,
      'username': username,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'role': role,
    });
  }

// Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    await _firebaseAuth.signOut();
  }
}
