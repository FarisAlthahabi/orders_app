part of '../profile_cubit.dart';

@immutable
class ProfileState extends GeneralProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final CustomerModel customer;

  ProfileSuccess(this.customer);
}

final class ProfileFail extends ProfileState {
  final String messsage;

  ProfileFail(this.messsage);
}
