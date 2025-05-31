part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingToLoginState extends AuthState {}

final class SuccessToLoginState extends AuthState {
  final LoginModel loginModel;
  final String msg;
  SuccessToLoginState({required this.loginModel, required this.msg});
}

final class ErrorToLoginState extends AuthState {
  final String msg;

  ErrorToLoginState({required this.msg});
}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {
  final String message;
  LogoutFailure(this.message);
}
