part of '../order_details_cubit.dart';

@immutable
class RemoveProductFromOrderState extends GeneralOrderDetailsState {}

final class RemoveProductFromOrderInitial extends RemoveProductFromOrderState {}

final class RemoveProductFromOrderLoading extends RemoveProductFromOrderState {}

final class RemoveProductFromOrderSuccess extends RemoveProductFromOrderState {
  final String message;

  RemoveProductFromOrderSuccess(this.message);
}

final class RemoveProductFromOrderFail extends RemoveProductFromOrderState {
  final String message;

  RemoveProductFromOrderFail(this.message);
}
