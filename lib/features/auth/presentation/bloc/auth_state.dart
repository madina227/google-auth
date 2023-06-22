part of'auth_bloc.dart';

class AuthState extends Equatable {
  final String firstName;
  final String lastName;

  const AuthState({this.firstName = '', this.lastName = ''});

  AuthState copyWith({
    String? firstName,
    String? lastName,
  }) =>
      AuthState(firstName: firstName ?? this.firstName, lastName: lastName ?? this.lastName);

  @override
  List<Object?> get props => [firstName, lastName];
}
