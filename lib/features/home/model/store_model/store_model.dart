import 'package:flutter/material.dart';

@immutable
class StoreModel {
  const StoreModel({
    required this.id,
    required this.name,
    required this.image,
    required this.location,
  });

  final int id;
  final String name;
  final String image;
  final String location;
}

abstract class Stores {
  static final localStores = List.generate(
    8,
    (index) => StoreModel(
      id: index,
      name: "Store Name ${index + 1}",
      image: "",
      location: "Damascus ,syria",
    ),
  );
}
