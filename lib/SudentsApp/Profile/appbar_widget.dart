import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../SignupAndLogin/app.dart';

AppBar BuildAppBar(BuildContext context) {
  const light_dark_mode_icon = CupertinoIcons.moon_stars;
  _gotToAppPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const App()),
        (Route<dynamic> route) => false);
  }

  _logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('username', '');
    sharedPreferences.setString('email', '');
    _gotToAppPage();
  }

  return AppBar(
    leading: const BackButton(
      color: Colors.black87,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        color: Colors.black87,
        icon: const Icon(light_dark_mode_icon),
        onPressed: () {},
      ),
      IconButton(
        color: Colors.red.shade900,
        icon: const Icon(Icons.logout_rounded),
        onPressed: () {
          _logOut();
        },
      ),
    ],
  );
}
