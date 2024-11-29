import 'package:flutter/material.dart';

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
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(size: 40),
      leading: leading,
      leadingWidth: leadingWidth,
      title: title,
      actions: actions,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
