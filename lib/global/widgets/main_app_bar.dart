import 'package:flutter/material.dart';
import 'package:orders_app/global/gen/assets.gen.dart';
import 'package:orders_app/global/theme/components/colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.toolbarHeight = kToolbarHeight,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
    this.backgroundColor,
    this.leadingWidth,
  });

  final double toolbarHeight;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final double? leadingWidth;
  final String? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(size: 40),
      leading: leading,
      leadingWidth: leadingWidth,
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                height: 1.22,
              ),
            )
          : null,
      actions: [
        Assets.images.logo.svg(height: 37, width: 37),
        SizedBox(width: 20),
        ...?actions,
      ],
      backgroundColor: backgroundColor ?? AppColors.whiteShade,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
