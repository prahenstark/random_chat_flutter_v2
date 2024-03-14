import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AppAuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final _controller = StreamController<AppAuthenticationStatus>();

  AuthenticationRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<AppAuthenticationStatus> get status async* {
    yield* _firebaseAuth.authStateChanges().map((user) {
      return user != null
          ? AppAuthenticationStatus.authenticated
          : AppAuthenticationStatus.unauthenticated;
    });
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}


  void dispose() {}
}




// import 'dart:async';

// enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// class AuthenticationRepository {
//   final _controller = StreamController<AuthenticationStatus>();

//   Stream<AuthenticationStatus> get status async* {
//     await Future<void>.delayed(const Duration(seconds: 1));
//     yield AuthenticationStatus.unauthenticated;
//     yield* _controller.stream;
//   }

//   Future<void> logIn({
//     required String username,
//     required String password,
//   }) async {
//     await Future.delayed(
//       const Duration(milliseconds: 300),
//       () => _controller.add(AuthenticationStatus.authenticated),
//     );
//   }

//   void logOut() {
//     _controller.add(AuthenticationStatus.unauthenticated);
//   }

//   void dispose() => _controller.close();
// }
