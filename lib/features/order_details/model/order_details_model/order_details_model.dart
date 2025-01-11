import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'package:orders_app/features/products/model/product_model/product_model.dart';

part 'order_details_model.g.dart';

@JsonSerializable()
@immutable
class OrderDetailsModel {
  const OrderDetailsModel({
    required this.product,
    required this.quantityOrdered,
    required this.totalPrice,
  });

  final ProductModel product;

  final int quantityOrdered;

  @JsonKey(name: 'total_price')
  final int totalPrice;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);

  OrderDetailsModel copyWith({
    ProductModel? product,
    int? quantityOrdered,
    int? totalPrice,
  }) {
    return OrderDetailsModel(
      product: product ?? this.product,
      quantityOrdered: quantityOrdered ?? this.quantityOrdered,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
