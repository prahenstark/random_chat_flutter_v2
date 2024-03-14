import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:random_chat_flutter_v2/authentication/authentication.dart';
import 'package:formz/formz.dart';
import 'package:random_chat_flutter_v2/login/models/email.dart';
import 'package:random_chat_flutter_v2/login/models/password.dart';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  // final UserRepository _userRepository;

  LoginBloc({
    required AuthenticationRepository authenticationRepository,
    // required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        // _userRepository = userRepository,
        super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapFormSubmittedToState();
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  LoginState _mapEmailChangedToState(
      LoginEmailChanged event, LoginState state) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
    );
  }

  LoginState _mapPasswordChangedToState(
      LoginPasswordChanged event, LoginState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password]),
    );
  }

  Stream<LoginState> _mapFormSubmittedToState() async* {
    if (state.status.isSuccess) {
      yield state.copyWith(status: FormzSubmissionStatus.inProgress);
      try {
        await _authenticationRepository.logIn(
          email: state.email.value,
          password: state.password.value,
        );
        yield state.copyWith(status: FormzSubmissionStatus.success);
      } catch (_) {
        yield state.copyWith(status: FormzSubmissionStatus.failure);
      }
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield state.copyWith(status: FormzSubmissionStatus.inProgress);
    try {
      // Initiate Google Sign-In Process
      final User? user = await _authenticationRepository.signInWithGoogle();
      if (user != null) {
        yield state.copyWith(status: FormzSubmissionStatus.success);
      } else {
        yield state.copyWith(status: FormzSubmissionStatus.failure);
      }
    } catch (_) {
      yield state.copyWith(status: FormzSubmissionStatus.failure);
    }
  }
}






// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:random_chat_flutter_v2/login/login.dart';
// import 'package:formz/formz.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc({
//     required AuthenticationRepository authenticationRepository,
//   })  : _authenticationRepository = authenticationRepository,
//         super(const LoginState()) {
//     on<LoginUsernameChanged>(_onUsernameChanged);
//     on<LoginPasswordChanged>(_onPasswordChanged);
//     on<LoginSubmitted>(_onSubmitted);
//   }

//   final AuthenticationRepository _authenticationRepository;

//   void _onUsernameChanged(
//     LoginUsernameChanged event,
//     Emitter<LoginState> emit,
//   ) {
//     final username = Username.dirty(event.username);
//     emit(
//       state.copyWith(
//         username: username,
//         isValid: Formz.validate([state.password, username]),
//       ),
//     );
//   }

//   void _onPasswordChanged(
//     LoginPasswordChanged event,
//     Emitter<LoginState> emit,
//   ) {
//     final password = Password.dirty(event.password);
//     emit(
//       state.copyWith(
//         password: password,
//         isValid: Formz.validate([password, state.username]),
//       ),
//     );
//   }

//   Future<void> _onSubmitted(
//     LoginSubmitted event,
//     Emitter<LoginState> emit,
//   ) async {
//     if (state.isValid) {
//       emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
//       try {
//         await _authenticationRepository.logIn(
//           username: state.username.value,
//           password: state.password.value,
//         );
//         emit(state.copyWith(status: FormzSubmissionStatus.success));
//       } catch (_) {
//         emit(state.copyWith(status: FormzSubmissionStatus.failure));
//       }
//     }
//   }
// }
