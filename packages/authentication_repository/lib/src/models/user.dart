import 'package:equatable/equatable.dart';

enum AccountType { buyer, seller }

class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.accountType, // Add accountType property
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// The current user's account type (buyer or seller).
  final AccountType? accountType; // Add accountType property

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

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
  List<Object?> get props => [email, id, name, photo, accountType];
}
