part of '../orders_cubit.dart';

@immutable
class AddToDriverOrdersState extends GeneralOrdersState{}

final class AddToDriverOrdersInitial extends AddToDriverOrdersState {}

final class AddToDriverOrdersLoading extends AddToDriverOrdersState {}

final class AddToDriverOrdersSuccess extends AddToDriverOrdersState {
   final String message;

  AddToDriverOrdersSuccess(this.message);
}

final class AddToDriverOrdersFail extends AddToDriverOrdersState {
  final String error;

  AddToDriverOrdersFail(this.error);
}

