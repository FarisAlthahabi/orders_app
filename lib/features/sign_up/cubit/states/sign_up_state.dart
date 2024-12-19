part of '../sign_up_cubit.dart';

@immutable
class SignUpState extends GeneralSignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final String message;

  SignUpSuccess(this.message);
}

final class SignUpFail extends SignUpState {
  final String message;

  SignUpFail(this.message);
}

final class SignInSuccess extends SignUpState {
  final String message;

  SignInSuccess(this.message);
}
