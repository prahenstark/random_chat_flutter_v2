import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'google_signin_event.dart';
part 'google_signin_state.dart';

class GoogleSigninBloc extends Bloc<GoogleSigninEvent, GoogleSigninState> {
  GoogleSigninBloc() : super(GoogleSigninInitial()) {
    on<GoogleSigninEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
