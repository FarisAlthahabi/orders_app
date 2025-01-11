import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
@immutable
class OrderItemModel {
  const OrderItemModel({
    int? productId,
    int? quantity,
  })  : _productId = productId,
        _quantity = quantity;

  final int? _productId;

  final int? _quantity;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItemModel copyWith({
    int? productId,
    int? quantity,
  }) {
    return OrderItemModel(
      productId: productId ?? _productId,
      quantity: quantity ?? _quantity,
    );
  }

  @JsonKey(name: 'product_id')
  int get productId {
    return _productId ?? (throw "Product id can't be empty");
  }

  int get quantity {
    return _quantity ?? (throw "Quantity can't be empty");
  }
}
