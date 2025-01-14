part of '../driver_order_cubit.dart';

@immutable
class DriverOrderState extends GeneralDriverOrderState{}

final class DriverOrderInitial extends DriverOrderState {}

final class DriverOrderLoading extends DriverOrderState {}

final class DriverOrderSuccess extends DriverOrderState {
  final List<OrderModel> orders;

  DriverOrderSuccess(this.orders);
}

final class DriverOrderEmpty extends DriverOrderState {
  final String message;

  DriverOrderEmpty(this.message);
}

final class DriverOrderFail extends DriverOrderState {
  final String error;

  DriverOrderFail(this.error);
}
