import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orders_app/features/profile/model/customer_model/customer_model.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
@immutable
class SignInModel {
  const SignInModel({
    required this.token,
    required this.customer,
  });

  @JsonKey(name: "access_token")
  final String token;

  final CustomerModel customer;

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}
