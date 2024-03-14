import 'package:user_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<MyUser?> getUser() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return MyUser(id: currentUser.uid);
    } else {
      return null;
    }
  }
}





// import 'dart:async';

// import 'package:user_repository/src/models/models.dart';
// import 'package:uuid/uuid.dart';

// class UserRepository {
//   User? _user;

//   Future<User?> getUser() async {
//     if (_user != null) return _user;
//     return Future.delayed(
//       const Duration(milliseconds: 300),
//       () => _user = User(const Uuid().v4()),
//     );
//   }
// }
