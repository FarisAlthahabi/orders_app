part of '../order_details_cubit.dart';

@immutable
class UpdateProductQuantityInOrderState extends GeneralOrderDetailsState {}

final class UpdateProductQuantityInOrderInitial
    extends UpdateProductQuantityInOrderState {}

final class UpdateProductQuantityInOrderLoading
    extends UpdateProductQuantityInOrderState {}

final class UpdateProductQuantityInOrderSuccess
    extends UpdateProductQuantityInOrderState {
  final String message;

  UpdateProductQuantityInOrderSuccess(this.message);
}

final class UpdateProductQuantityInOrderFail
    extends UpdateProductQuantityInOrderState {
  final String message;

  UpdateProductQuantityInOrderFail(this.message);
}
