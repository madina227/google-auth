part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {
  final VoidCallback onSuccess;
  final VoidCallback onError;

  const SignInWithGoogleEvent({required this.onError, required this.onSuccess});
}

class SignOutWithGoogleEvent extends AuthEvent {
  final VoidCallback onSuccess;
  final VoidCallback onError;
  const SignOutWithGoogleEvent({required this.onError, required this.onSuccess});
}
