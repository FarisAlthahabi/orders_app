import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';

class AppImageWidget extends StatelessWidget {
  const AppImageWidget({
    super.key,
    required this.url,
    this.borderRadius = BorderRadius.zero,
    this.fit,
    this.width,
    this.height,
    this.border,
    this.imageBuilder,
  });

  final String? url;
  final BorderRadiusGeometry borderRadius;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Border? border;
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          errorListener: (_) {},
          imageUrl: url ?? "",
          fit: fit,
          imageBuilder: imageBuilder,
          placeholder: (_, __) => const ColoredBox(
            color: AppColors.greyShade2,
          ),
          errorWidget: (_, __, ___) => const ColoredBox(
            color: AppColors.greyShade2,
          ),
        ),
      ),
    );
  }
}
