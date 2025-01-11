import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orders_app/global/utils/json_utils.dart';

part 'customer_model.g.dart';

@JsonSerializable()
@immutable
class CustomerModel {
  const CustomerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.location,
    this.photo,
  });

  final int id;

  @JsonKey(name: "first_name")
  final String firstName;

  @JsonKey(name: "last_name")
  final String lastName;

  @JsonKey(name: "phone")
  final String phoneNumber;

  final String? location;

  @JsonKey(
    fromJson: JsonUtils.setFileUrlFromJson,
    readValue: JsonUtils.readValue,
  )
  final String? photo;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
