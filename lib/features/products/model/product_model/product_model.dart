import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/global/utils/json_converters/double_converter.dart';
import 'package:orders_app/global/utils/json_converters/int_converter.dart';
import 'package:orders_app/global/utils/json_utils.dart';

part 'product_model.g.dart';

@JsonSerializable()
@immutable
class ProductModel {
  const ProductModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.name,
    this.shopId,
    this.description,
    this.image,
  });

  final int id;

  @JsonKey(name: 'shop_id')
  final int? shopId;

  final String name;

  @IntConverter()
  final int quantity;

  @DoubleConverter()
  final double price;

  final String? description;

  @JsonKey(
    fromJson: JsonUtils.setFileUrlFromJson,
    readValue: JsonUtils.readValue,
  )
  final String? image;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel copyWith({
    int? id,
    int? shopId,
    String? name,
    int? quantity,
    double? price,
    String? description,
    String? image,
  }) {
    return ProductModel(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}