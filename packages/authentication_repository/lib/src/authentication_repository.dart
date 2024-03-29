import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

/// {@template sign_up_with_email_and_password_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// {@template log_in_with_google_failure}
/// Thrown during the sign in with google process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class LogInWithGoogleFailure implements Exception {
  /// {@macro log_in_with_google_failure}
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }

  /// The associated error message.
  final String message;
}

// Add this exception class to your other exceptions
class SignInAnonymouslyFailure implements Exception {
  const SignInAnonymouslyFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  final String message;
}

class SignInWithAppleFailure implements Exception {}

class LinkWithEmailAndPasswordFailure implements Exception {
  const LinkWithEmailAndPasswordFailure({required this.message});
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        isUserVerified = false,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
                clientId:
                    "1030211861772-qtqdrkr147o9eoi1rce500quk6hp6cq3.apps.googleusercontent.com") {
    checkForExistingUser();
  }

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  bool isUserVerified;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      print("auth state did change here");
      print(firebaseUser.toString());

      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;

      _cache.write(key: userCacheKey, value: user);

      this.isUserVerified = !(user.needsVerification ?? true);
      return user;
    });
  }

  Future<String> getIdToken() async {
    if (_firebaseAuth.currentUser == null) {
      throw Exception("No authenticated user");
    }
    return await _firebaseAuth.currentUser?.getIdToken() ?? "";
  }

  ///Return if the user is anonymous
  ///
  ///Returns Bool
  // In AuthenticationRepository class
  bool get isAnonymous => _firebaseAuth.currentUser?.isAnonymous ?? false;

  /// Returns any persisted user
  /// Defaults to executing void
  Future<void> checkForExistingUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        _cache.write(key: userCacheKey, value: firebaseUser.toUser);
      }
    } catch (_) {
      // Handle any exceptions here if needed
    }
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(currentUser);
      print('cu');
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          id: credential.user!.uid,
        ),
      );

      await sendEmailVerification();
      print('sent verification');
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  // // Link Anonymous and actual accounts here
  // // In the future this maybe
  // Future<void> linkWithEmailAndPassword(
  //     {required String email, required String password}) async {
  //   try {
  //     final userCredential = _firebaseAuth.currentUser;
  //     final credential = firebase_auth.EmailAuthProvider.credential(
  //         email: email, password: password);
  //     await userCredential?.linkWithCredential(credential);
  //   } on firebase_auth.FirebaseAuthException catch (e) {
  //     // You can handle specific exceptions here if needed
  //     throw LinkWithEmailAndPasswordFailure(
  //         message: e.message ?? 'Unknown error occurred');
  //   }
  // }

  // Add the signInAnonymously method to your AuthenticationRepository class

  signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on firebase_auth.FirebaseAuthException catch (e) {
      // Handle any specific errors here if needed
      throw SignInAnonymouslyFailure(e.code);
    } catch (_) {
      throw const SignInAnonymouslyFailure();
    }
  }

  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set your own clientId and redirectUri
          clientId: 'your.client.id',
          redirectUri: Uri.parse('https://your.redirect.uri'),
        ),
        nonce: 'nonce', // Consider generating a secure random nonce
      );

      final oauthCredential =
          firebase_auth.OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
        // rawNonce: credential.rawNonce,
      );

      await _firebaseAuth.signInWithCredential(oauthCredential);
    } catch (e) {
      throw SignInWithAppleFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> sendEmailVerification() async {
    final firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser != null && !firebaseUser.emailVerified) {
      await firebaseUser.sendEmailVerification();
    }
  }

  // final _emailVerificationController = StreamController<bool>();
  // Stream<bool> get isEmailVerified => _emailVerificationController.stream;

  // // ignore: unused_element
  // void _checkEmailVerificationStatus() async {
  //   // Stop checking if the controller has been closed.
  //   if (_emailVerificationController.isClosed) return;

  //   final firebaseUser = _firebaseAuth.currentUser;
  //   if (firebaseUser != null) {
  //     await firebaseUser.reload();
  //     _emailVerificationController.add(firebaseUser.emailVerified);

  //     if (!firebaseUser.emailVerified) {
  //       // Check again after a delay.
  //       await Future.delayed(Duration(seconds: 5));
  //       _checkEmailVerificationStatus();
  //     }
  //   }
  // }

  Future<void> isVerificationNeeded() async {
    print('is verification needed?');
    await _firebaseAuth.currentUser?.reload();

    print(_firebaseAuth.currentUser.toString());

    // User user = _firebaseAuth.currentUser == null ? User.empty : _firebaseAuth.currentUser!.toUser;
    // _cache.write(key: userCacheKey, value: user);
    print(_firebaseAuth.currentUser?.emailVerified);
    this.isUserVerified = _firebaseAuth.currentUser?.emailVerified ?? false;
  }
  //This will always exist so probably useless?
  // void dispose() {
  //   _emailVerificationController.close();
  // }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);

      // _emailVerificationController.close();
    } catch (_) {
      throw LogOutFailure();
    }
  }

  String? getEmailIfAnyElseNull() {
    return this.currentUser.email;
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
        needsVerification: !emailVerified);
  }
}
