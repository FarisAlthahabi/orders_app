part of '../profile_cubit.dart';

@immutable
class UpdateProfileState extends GeneralProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileSuccess extends UpdateProfileState {
  final CustomerModel customer;
  final String message;

  UpdateProfileSuccess(this.customer, this.message);
}

final class UpdateProfileFail extends UpdateProfileState {
  final String messsage;

  UpdateProfileFail(this.messsage);
}
