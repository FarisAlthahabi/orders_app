import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

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

  final String? photo;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}

abstract class Stores {
  static final localStores = List.generate(
    8,
    (index) => StoreModel(
      id: index,
      name: "Store Name ${index + 1}",
      photo: "",
      location: "Damascus ,syria",
      category: 'category',
    ),
  );
}
