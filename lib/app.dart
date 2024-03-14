import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_chat_flutter_v2/authentication/authentication.dart';
import 'package:random_chat_flutter_v2/home/home.dart';
import 'package:random_chat_flutter_v2/login/login.dart';
import 'package:random_chat_flutter_v2/splash/splash.dart';
import 'package:user_repository/user_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState()  {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
          // Add more bloc providers if needed
        ],
        child: MaterialApp(
          title: 'Your App Title',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: GlobalKey<NavigatorState>(),
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AppAuthenticationStatus.authenticated:
                    Navigator.of(context).pushAndRemoveUntil<void>(
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false,
                    );
                    break;
                  case AppAuthenticationStatus.unauthenticated:
                    Navigator.of(context).pushAndRemoveUntil<void>(
                      MaterialPageRoute(builder: (_) => LoginPage()),
                      (route) => false,
                    );
                    break;
                  case AppAuthenticationStatus.unknown:
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
        ),
      ),
    );
  }
}





// import 'package:authentication_repository/authentication_repository.dart' as auth_repo;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:random_chat_flutter_v2/authentication/authentication.dart';
// import 'package:random_chat_flutter_v2/home/home.dart';
// import 'package:random_chat_flutter_v2/splash/splash.dart';
// import 'package:user_repository/user_repository.dart';

// class App extends StatefulWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   late final AuthenticationRepository _authenticationRepository;
//   late final UserRepository _userRepository;

//   @override
//   void initState() {
//     WidgetsFlutterBinding.ensureInitialized();
//     super.initState();
//     _authenticationRepository = AuthenticationRepository();
//     _userRepository = UserRepository();
//   }

//   @override
//   void dispose() {
//     _authenticationRepository.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: _authenticationRepository,
//       child: BlocProvider(
//         create: (_) => AuthenticationBloc(
//           authenticationRepository: _authenticationRepository,
//           userRepository: _userRepository,
//         ),
//         child: const AppView(),
//       ),
//     );
//   }
// }

// class AppView extends StatefulWidget {
//   const AppView({Key? key}) : super(key: key);

//   @override
//   State<AppView> createState() => _AppViewState();
// }

// class _AppViewState extends State<AppView> {
//   final _navigatorKey = GlobalKey<NavigatorState>();

//   NavigatorState get _navigator => _navigatorKey.currentState!;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: _navigatorKey,
//       builder: (context, child) {
//         return BlocListener<AuthenticationBloc, AuthenticationState>(
//           listener: (context, state) {
//             switch (state.status) {
//               case auth_repo.AuthenticationStatus.authenticated: // Use the alias here
//                 _navigator.pushAndRemoveUntil<void>(
//                   HomePage.route(),
//                   (route) => false,
//                 );
//                 break;
//               case auth_repo.AuthenticationStatus.unauthenticated: // Use the alias here
//                 _navigator.pushAndRemoveUntil<void>(
//                   LoginPage.route(),
//                   (route) => false,
//                 );
//                 break;
//               case auth_repo.AuthenticationStatus.unknown: // Use the alias here
//                 break;
//             }
//           },
//           child: child,
//         );
//       },
//       onGenerateRoute: (_) => SplashPage.route(),
//     );
//   }
// }





// import 'package:authentication_repository/authentication_repository.dart';
// // import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:random_chat_flutter_v2/authentication/authentication.dart';
// import 'package:random_chat_flutter_v2/home/home.dart';
// import 'package:random_chat_flutter_v2/login/login.dart';
// import 'package:random_chat_flutter_v2/splash/splash.dart';
// import 'package:user_repository/user_repository.dart';

// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   late final AuthenticationRepository _authenticationRepository;
//   late final UserRepository _userRepository;

//   @override
//   void initState() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     // await Firebase.initializeApp();

//     super.initState();
//     _authenticationRepository = AuthenticationRepository();
//     _userRepository = UserRepository();
//   }

//   @override
//   void dispose() {
//     _authenticationRepository.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: _authenticationRepository,
//       child: BlocProvider(
//         create: (_) => AuthenticationBloc(
//           authenticationRepository: _authenticationRepository,
//           userRepository: _userRepository,
//         ),
//         child: const AppView(),
//       ),
//     );
//   }
// }

// class AppView extends StatefulWidget {
//   const AppView({super.key});

//   @override
//   State<AppView> createState() => _AppViewState();
// }

// class _AppViewState extends State<AppView> {
//   final _navigatorKey = GlobalKey<NavigatorState>();

//   NavigatorState get _navigator => _navigatorKey.currentState!;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: _navigatorKey,
//       builder: (context, child) {
//         return BlocListener<AuthenticationBloc, AuthenticationState>(
//           listener: (context, state) {
//             switch (state.status) {
//               case AuthenticationStatus.authenticated:
//                 _navigator.pushAndRemoveUntil<void>(
//                   HomePage.route(),
//                   (route) => false,
//                 );
//               case AuthenticationStatus.unauthenticated:
//                 _navigator.pushAndRemoveUntil<void>(
//                   LoginPage.route(),
//                   (route) => false,
//                 );
//               case AuthenticationStatus.unknown:
//                 break;
//             }
//           },
//           child: child,
//         );
//       },
//       onGenerateRoute: (_) => SplashPage.route(),
//     );
//   }
// }
