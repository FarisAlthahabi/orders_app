import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_order_status_model.g.dart';

@JsonSerializable()
@immutable
class UpdateOrderStatusModel {
  const UpdateOrderStatusModel({
    String? status,
    String? payment,
  })  : _status = status,
        _payment = payment;

  factory UpdateOrderStatusModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderStatusModelFromJson(json);

  final String? _status;
  final String? _payment;

  UpdateOrderStatusModel copyWith({
    String? status,
    String? payment,
  }) {
    return UpdateOrderStatusModel(
      status: status ?? _status,
      payment: payment ?? _payment,
    );
  }

  String toJsonStr() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => _$UpdateOrderStatusModelToJson(this);

  String get payment {
    return _payment ?? (throw "Payment can't be empty");
  }

  String get status {
    return _status ?? (throw "Status can't be empty");
  }
}
