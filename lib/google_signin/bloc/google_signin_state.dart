part of 'google_signin_bloc.dart';

sealed class GoogleSigninState extends Equatable {
  const GoogleSigninState();
  
  @override
  List<Object> get props => [];
}

final class GoogleSigninInitial extends GoogleSigninState {}
