import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum AccountType { buyer, seller, guest }

class User extends Equatable {
  /// {@macro user}
  const User({
    this.id,
    this.email,
    this.name,
    this.photo,
    this.needsVerification,
    this.accountType, // Add accountType property
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String? id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Boolean for if I need to verify
  final bool? needsVerification;

  /// The current user's account type (buyer or seller).
  final AccountType? accountType; // Add accountType property

  /// Empty user which represents an unauthenticated user.
  static const empty = User();

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  bool get isEmptyForWeb =>
      this == User.empty ||
      ((this.id?.isNotEmpty ?? true) && this.accountType == null);

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  // In the User class
  User.fromDocument(DocumentSnapshot doc)
      : id = doc.id,
        email = (doc.data() as Map<String, dynamic>)['email'] as String?,
        name = (doc.data() as Map<String, dynamic>)['name'] as String?,
        photo = (doc.data() as Map<String, dynamic>)['photo'] as String?,
        needsVerification = true,
        accountType = _accountTypeFromString(
            (doc.data() as Map<String, dynamic>)['role'] as String?);

  static AccountType? _accountTypeFromString(String? accountTypeString) {
    if (accountTypeString == null) return null;
    return AccountType.values
        .firstWhere((e) => e.toString().split('.').last == accountTypeString);
  }

  // In the User class
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photo': photo,
      'accountType': accountType?.toString().split('.').last,
    };
  }

  // Add copyWith method
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? photo,
    AccountType? accountType, // Add accountType parameter
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      accountType:
          accountType ?? this.accountType, // Update accountType property
    );
  }

  @override
  List<Object?> get props =>
      [email, id, name, photo, accountType, needsVerification];
}
