import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:apple_leaf/configs/theme.dart';

AppBar customAppBar(
  BuildContext context, {
  String title = '',
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: neutralWhite,
    surfaceTintColor: neutralWhite,

    // Leading
    leading: IconButton(
      icon: const Icon(
        IconsaxPlusLinear.arrow_left,
        color: neutralBlack,
      ),
      onPressed: () => Navigator.pop(context),
    ),

    // Title
    toolbarHeight: 42,
    titleSpacing: 0,
    title: Text(
      title,
      style: mediumTS.copyWith(
        fontSize: 20,
        color: neutralBlack,
      ),
    ),

    // Divider
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(10.0),
      child: Container(
        color: neutral100,
        height: 1,
      ),
    ),

    actions: actions,
  );
}

AppBar mainAppBar(BuildContext context, {required String title}) {
  return AppBar(
    backgroundColor: neutralWhite,
    surfaceTintColor: neutralWhite,

    // Title
    title: Text(
      title,
      style: mediumTS.copyWith(
        fontSize: 20,
        color: neutralBlack,
      ),
    ),

    // Divider
    toolbarHeight: 52,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(10.0),
      child: Container(
        color: neutral100,
        height: 1,
      ),
    ),
  );
}
