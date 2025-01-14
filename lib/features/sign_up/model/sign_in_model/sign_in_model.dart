import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_model.g.dart';

@JsonSerializable()
@immutable
class SignInModel {
  const SignInModel({
    required this.token,
  });

  @JsonKey(name: "access_token")
  final String token;

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignInModelToJson(this);
}
