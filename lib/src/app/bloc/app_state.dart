part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, loggingOut, needsVerification }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.loggingOut() : this._(status: AppStatus.loggingOut);

  const AppState.needsVerification()
      : this._(status: AppStatus.needsVerification);
  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];

  AppState copyWith({AppStatus? status, User? user}) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
