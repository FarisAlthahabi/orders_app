part of '../orders_cubit.dart';

@immutable
class CancelOrderState extends GeneralOrdersState{}

final class CancelOrderInitial extends CancelOrderState {}

final class CancelOrderLoading extends CancelOrderState {}

final class CancelOrderSuccess extends CancelOrderState {
   final String message;

  CancelOrderSuccess(this.message);
}

final class CancelOrderFail extends CancelOrderState {
  final String error;

  CancelOrderFail(this.error);
}

