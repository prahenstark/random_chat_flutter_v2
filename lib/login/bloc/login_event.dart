part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}




// part of 'login_bloc.dart';

// sealed class LoginEvent extends Equatable {
//   const LoginEvent();

//   @override
//   List<Object> get props => [];
// }

// final class LoginUsernameChanged extends LoginEvent {
//   const LoginUsernameChanged(this.username);

//   final String username;

//   @override
//   List<Object> get props => [username];
// }

// final class LoginPasswordChanged extends LoginEvent {
//   const LoginPasswordChanged(this.password);

//   final String password;

//   @override
//   List<Object> get props => [password];
// }

// final class LoginSubmitted extends LoginEvent {
//   const LoginSubmitted();
// }
