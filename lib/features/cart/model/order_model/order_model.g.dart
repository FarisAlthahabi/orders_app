// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      payment: json['payment'] as String,
      totalPrice:
          const DoubleConverter().fromJson(json['total_price'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      customerId: (json['customer_id'] as num?)?.toInt(),
      driverId: (json['driver_id'] as num?)?.toInt(),
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'driver_id': instance.driverId,
      'status': instance.status,
      'payment': instance.payment,
      'total_price': const DoubleConverter().toJson(instance.totalPrice),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'customer': instance.customer,
    };
