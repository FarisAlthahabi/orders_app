class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.availableAmount,
    required this.price,
    required this.isFavorite,
  });

  final int id;

  final String name;

  final String image;

  final int availableAmount;

  final double price;

  final bool isFavorite;

  ProductModel copyWith({
    int? id,
    String? name,
    String? image,
    int? availableAmount,
    double? price,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      availableAmount: availableAmount ?? this.availableAmount,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

abstract class Products {
  static final localProducts = List.generate(
    8,
    (index) => ProductModel(
      id: index,
      name: "Product ${index + 1}",
      image: "",
      availableAmount: index + 1,
      price: (index+1) * 1000,
      isFavorite: false
    ),
  );
}
