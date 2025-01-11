// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: (json['id'] as num).toInt(),
      quantity: const IntConverter().fromJson(json['quantity']),
      price: const DoubleConverter().fromJson(json['price'] as String),
      name: json['name'] as String,
      shopId: (json['shop_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      image: JsonUtils.setFileUrlFromJson(
          JsonUtils.readValue(json, 'image') as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_id': instance.shopId,
      'name': instance.name,
      'quantity': const IntConverter().toJson(instance.quantity),
      'price': const DoubleConverter().toJson(instance.price),
      'description': instance.description,
      'image': instance.image,
    };
