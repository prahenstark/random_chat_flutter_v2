import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(
          status as AppAuthenticationStatus)), // Use the new event here
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AppAuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      // ignore: constant_pattern_never_matches_value_type
      case AppAuthenticationStatus.unauthenticated:
        emit(const AuthenticationState.unauthenticated());
        break;
      // ignore: constant_pattern_never_matches_value_type
      case AppAuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
        break;
      // ignore: constant_pattern_never_matches_value_type
      case AppAuthenticationStatus.unknown:
        emit(const AuthenticationState.unknown());
        break;

      default:
        emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<MyUser?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}












// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:user_repository/user_repository.dart';
// import 'package:authentication_repository/authentication_repository.dart';

// part 'authentication_event.dart';
// part 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final AuthenticationRepository _authenticationRepository;
//   final UserRepository _userRepository;

//   late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

//   AuthenticationBloc({
//     required AuthenticationRepository authenticationRepository,
//     required UserRepository userRepository,
//   })   : _authenticationRepository = authenticationRepository,
//         _userRepository = userRepository,
//         super(const AuthenticationState.unknown()) {
//     _authenticationStatusSubscription = _authenticationRepository.status.listen((status) {
//       add(_AuthenticationStatusChanged(status));
//     });
//   }

//   @override
//   Stream<AuthenticationState> mapEventToState(
//     AuthenticationEvent event,
//   ) async* {
//     if (event is AppStarted) {
//       yield* _mapAppStartedToState();
//     } else if (event is UserLoggedIn) {
//       yield* _mapUserLoggedInToState();
//     } else if (event is UserLoggedOut) {
//       yield* _mapUserLoggedOutToState();
//     }
//   }

//   Stream<AuthenticationState> _mapAppStartedToState() async* {
//     final isSignedIn = await _userRepository.getUser() != null;
//     if (isSignedIn) {
//       yield AuthenticationState.authenticated(await _userRepository.getUser());
//     } else {
//       yield const AuthenticationState.unauthenticated();
//     }
//   }

//   Stream<AuthenticationState> _mapUserLoggedInToState() async* {
//     yield AuthenticationState.authenticated(await _userRepository.getUser());
//   }

//   Stream<AuthenticationState> _mapUserLoggedOutToState() async* {
//     yield const AuthenticationState.unauthenticated();
//     _authenticationRepository.logOut();
//   }

//   @override
//   Future<void> close() {
//     _authenticationStatusSubscription.cancel();
//     return super.close();
//   }
// }






// import 'dart:async';

// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:user_repository/user_repository.dart';

// part 'authentication_event.dart';
// part 'authentication_state.dart';

// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   AuthenticationBloc({
//     required AuthenticationRepository authenticationRepository,
//     required UserRepository userRepository,
//   })  : _authenticationRepository = authenticationRepository,
//         _userRepository = userRepository,
//         super(const AuthenticationState.unknown()) {
//     on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
//     on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
//     _authenticationStatusSubscription = _authenticationRepository.status.listen(
//       (status) => add(_AuthenticationStatusChanged(status)),
//     );
//   }

//   final AuthenticationRepository _authenticationRepository;
//   final UserRepository _userRepository;
//   late StreamSubscription<AuthenticationStatus>
//       _authenticationStatusSubscription;

//   @override
//   Future<void> close() {
//     _authenticationStatusSubscription.cancel();
//     return super.close();
//   }

//   Future<void> _onAuthenticationStatusChanged(
//     _AuthenticationStatusChanged event,
//     Emitter<AuthenticationState> emit,
//   ) async {
//     switch (event.status) {
//       case AuthenticationStatus.unauthenticated:
//         return emit(const AuthenticationState.unauthenticated());
//       case AuthenticationStatus.authenticated:
//         final user = await _tryGetUser();
//         return emit(
//           user != null
//               ? AuthenticationState.authenticated(user)
//               : const AuthenticationState.unauthenticated(),
//         );
//       case AuthenticationStatus.unknown:
//         return emit(const AuthenticationState.unknown());
//     }
//   }

//   void _onAuthenticationLogoutRequested(
//     AuthenticationLogoutRequested event,
//     Emitter<AuthenticationState> emit,
//   ) {
//     _authenticationRepository.logOut();
//   }

//   Future<User?> _tryGetUser() async {
//     try {
//       final user = await _userRepository.getUser();
//       return user;
//     } catch (_) {
//       return null;
//     }
//   }
// }
