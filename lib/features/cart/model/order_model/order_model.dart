// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:orders_app/features/profile/model/customer_model/customer_model.dart';
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
    this.customer,
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

  final CustomerModel? customer;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderModel copyWith({
    int? id,
    int? customerId,
    int? driverId,
    String? status,
    String? payment,
    double? totalPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
    CustomerModel? customer,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      driverId: driverId ?? this.driverId,
      status: status ?? this.status,
      payment: payment ?? this.payment,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      customer: customer ?? this.customer,
    );
  }
}
