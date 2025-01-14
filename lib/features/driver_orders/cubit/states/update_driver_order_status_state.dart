part of '../driver_order_cubit.dart';

@immutable
class UpdateDriverOrderStatusState extends GeneralDriverOrderState {}

final class UpdateDriverOrderStatusInitial
    extends UpdateDriverOrderStatusState {}

final class UpdateDriverOrderStatusLoading
    extends UpdateDriverOrderStatusState {}

final class UpdateDriverOrderStatusSuccess
    extends UpdateDriverOrderStatusState {
  final String message;

  UpdateDriverOrderStatusSuccess(this.message);
}

final class UpdateDriverOrderStatusFail extends UpdateDriverOrderStatusState {
  final String message;

  UpdateDriverOrderStatusFail(this.message);
}
