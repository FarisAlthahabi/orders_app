part of '../home_cubit.dart';

@immutable
class HomeState extends GeneralHomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<StoreModel> stores;

  HomeSuccess(this.stores);
}

final class HomeEmpty extends HomeState {
  final String message;

  HomeEmpty(this.message);
}

final class HomeFail extends HomeState {
  final String error;

  HomeFail(this.error);
}
