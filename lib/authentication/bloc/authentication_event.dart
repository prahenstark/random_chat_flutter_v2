part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AppAuthenticationStatus status;
}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}




// part of 'authentication_bloc.dart';

// @immutable
// abstract class AuthenticationEvent {}

// class AppStarted extends AuthenticationEvent {}

// class UserLoggedIn extends AuthenticationEvent {}

// class UserLoggedOut extends AuthenticationEvent {}




// part of 'authentication_bloc.dart';

// sealed class AuthenticationEvent {
//   const AuthenticationEvent();
// }

// final class _AuthenticationStatusChanged extends AuthenticationEvent {
//   const _AuthenticationStatusChanged(this.status);

//   final AuthenticationStatus status;
// }

// final class AuthenticationLogoutRequested extends AuthenticationEvent {}
