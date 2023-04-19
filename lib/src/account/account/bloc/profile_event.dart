// part of 'profile_bloc.dart';

// abstract class ProfileEvent extends Equatable {
//   const ProfileEvent();

//   @override
//   List<Object> get props => [];
// }

// class ProfileInitRequested extends ProfileEvent {}
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileInitRequested extends ProfileEvent {
  final String uid; // Add this line

  const ProfileInitRequested({required this.uid}); // Add this line
}
