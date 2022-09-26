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
        key: const Key('Logout'),
        color: Colors.redAccent,
        icon: const Icon(Icons.logout_rounded),
        onPressed: () {
          showModalBottomSheet(context: context,
              builder: (builder) => Container(
                padding: const EdgeInsets.all(15),
                height: 200,
                child: Column(
                  children: [
                    const Text("Are you sure you want to Sign Out?",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    TextButton(onPressed: (){
                      _logOut();
                    },
                        child: const Text("Sign Out", style: TextStyle(color: Colors.red))
                    ),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    },
                        child: const Text("Cancel")
                    ),
                  ],
                ),
              )
          );
        },
      ),
    ],
  );
}
