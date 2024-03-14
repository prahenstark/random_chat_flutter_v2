import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  const MyUser({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];

  static const empty = MyUser(id: '-');
}




// import 'package:equatable/equatable.dart';

// class User extends Equatable {
//   const User(this.id);

//   final String id;

//   @override
//   List<Object> get props => [id];

//   static const empty = User('-');
// }
