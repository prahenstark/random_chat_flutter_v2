import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:random_chat_flutter_v2/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App());
}
