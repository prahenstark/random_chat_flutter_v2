part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;

  @override
  List<Object?> get props => [email, password, status];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}







// part of 'login_bloc.dart';

// final class LoginState extends Equatable {
//   const LoginState({
//     this.status = FormzSubmissionStatus.initial,
//     this.username = const Username.pure(),
//     this.password = const Password.pure(),
//     this.isValid = false,
//   });

//   final FormzSubmissionStatus status;
//   final Username username;
//   final Password password;
//   final bool isValid;

//   LoginState copyWith({
//     FormzSubmissionStatus? status,
//     Username? username,
//     Password? password,
//     bool? isValid,
//   }) {
//     return LoginState(
//       status: status ?? this.status,
//       username: username ?? this.username,
//       password: password ?? this.password,
//       isValid: isValid ?? this.isValid,
//     );
//   }

//   @override
//   List<Object> get props => [status, username, password];
// }
