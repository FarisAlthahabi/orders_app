import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/widgets/main_app_bar.dart';

@RoutePage()
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return ProductDetailsPage(productId: productId);
  }
}

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
    );
  }
}
