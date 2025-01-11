// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsModel _$OrderDetailsModelFromJson(Map<String, dynamic> json) =>
    OrderDetailsModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantityOrdered: (json['quantityOrdered'] as num).toInt(),
      totalPrice: (json['total_price'] as num).toInt(),
    );

Map<String, dynamic> _$OrderDetailsModelToJson(OrderDetailsModel instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantityOrdered': instance.quantityOrdered,
      'total_price': instance.totalPrice,
    };
