import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:orders_app/global/utils/json_utils.dart';

part 'store_model.g.dart';

@JsonSerializable()
@immutable
class StoreModel {
  const StoreModel({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    this.photo,
  });

  final int id;

  final String name;

  final String location;

  final String category;

  @JsonKey(
    fromJson: JsonUtils.setFileUrlFromJson,
    readValue: JsonUtils.readValue,
  )
  final String? photo;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}

