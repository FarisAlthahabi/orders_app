part of '../orders_cubit.dart';

@immutable
class CreateOrderState extends GeneralOrdersState {
  final bool isProductsPage;

  CreateOrderState(this.isProductsPage);
}

class CreateOrderInitial extends CreateOrderState {
  CreateOrderInitial(super.isProductsPage);
}

class CreateOrderLoading extends CreateOrderState {
  CreateOrderLoading(super.isProductsPage);
}

class CreateOrderSuccess extends CreateOrderState {
  final String message;

  CreateOrderSuccess(this.message, super.isProductsPage);
}

class CreateOrderFail extends CreateOrderState {
  final String message;

  CreateOrderFail(this.message, super.isProductsPage);
}
