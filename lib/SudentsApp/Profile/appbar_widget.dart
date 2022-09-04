import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar BuildAppBar(BuildContext context) {
  final light_dark_mode_icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: BackButton(
      color: Colors.black87,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        color: Colors.black87,
        icon: Icon(light_dark_mode_icon),
        onPressed: () {},
      ),
    ],
  );
}
