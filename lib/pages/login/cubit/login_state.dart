part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();

  @override
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {

  const LoginLoading();

  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  final UserModel? user;
  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginError extends LoginState {
  final String error;
  const LoginError(this.error);

  @override
  List<Object?> get props => [error];
}
