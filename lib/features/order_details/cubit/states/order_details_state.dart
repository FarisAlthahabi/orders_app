part of '../order_details_cubit.dart';

@immutable
class OrderDetailsState extends GeneralOrderDetailsState{}

final class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsSuccess extends OrderDetailsState {
  final List<OrderDetailsModel> orderDetails;

  OrderDetailsSuccess(this.orderDetails);
}

class OrderDetailsEmpty extends OrderDetailsState {
  final String error;

  OrderDetailsEmpty(this.error);
}

class OrderDetailsFail extends OrderDetailsState {
  final String error;

  OrderDetailsFail(this.error);
}

