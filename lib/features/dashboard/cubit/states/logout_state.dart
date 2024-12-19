part of '../dashboard_cubit.dart';

@immutable
class LogoutState extends GeneralDashboardState{}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {
  final String message;

  LogoutSuccess(this.message);
}

final class LogoutFail extends LogoutState {
  final String message;

  LogoutFail(this.message);
}
