import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:orders_app/global/utils/json_converters/double_converter.dart';

part 'order_model.g.dart';

@JsonSerializable()
@immutable
class OrderModel {
  const OrderModel({
    required this.id,
    required this.status,
    required this.payment,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    this.customerId,
    this.driverId,
  });

  final int id;

  @JsonKey(name: 'customer_id')
  final int? customerId;

  @JsonKey(name: 'driver_id')
  final int? driverId;

  final String status;

  final String payment;

  @DoubleConverter()
  @JsonKey(name: 'total_price')
  final double totalPrice;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
