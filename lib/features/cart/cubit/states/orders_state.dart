part of '../orders_cubit.dart';

@immutable
class OrdersState extends GeneralOrdersState{}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersSuccess extends OrdersState {
  final List<OrderModel> orders;

  OrdersSuccess(this.orders);
}

final class OrdersEmpty extends OrdersState {
  final String message;

  OrdersEmpty(this.message);
}

final class OrdersFail extends OrdersState {
  final String error;

  OrdersFail(this.error);
}

