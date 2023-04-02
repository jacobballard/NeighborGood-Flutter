part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, locationRequest }

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.locationRequest() : this._(status: AppStatus.locationRequest);
  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
