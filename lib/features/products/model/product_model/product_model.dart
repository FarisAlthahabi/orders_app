// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/global/utils/json_converters/double_converter.dart';
import 'package:orders_app/global/utils/json_converters/int_converter.dart';

part 'product_model.g.dart';

@JsonSerializable()
@immutable
class ProductModel {
  const ProductModel({
    required this.id,
    required this.shopId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.description,
    this.image,
  });

  final int id;

  @JsonKey(name: 'shop_id')
  final int shopId;

  final String name;

  @IntConverter()
  final int quantity;

  @DoubleConverter()
  final double price;

  final String description;

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
    bool? isFavorite,
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

abstract class Products {
  static final localProducts = List.generate(
    8,
    (index) => ProductModel(
      id: index,
      shopId: 1,
      name: "Product ${index + 1}",
      image: "",
      quantity: index + 1,
      price: (index + 1) * 1000,
      description: 'description',
    ),
  );
}
