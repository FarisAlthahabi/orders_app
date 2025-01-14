// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderStatusModel _$UpdateOrderStatusModelFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderStatusModel(
      status: json['status'] as String?,
      payment: json['payment'] as String?,
    );

Map<String, dynamic> _$UpdateOrderStatusModelToJson(
        UpdateOrderStatusModel instance) =>
    <String, dynamic>{
      'payment': instance.payment,
      'status': instance.status,
    };
