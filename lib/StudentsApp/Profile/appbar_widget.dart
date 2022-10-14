import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdp_wits_services/globals.dart' as globals;

import '../../SignupAndLogin/app.dart';

AppBar BuildAppBar(BuildContext context) {
  const lightDarkModeIcon = CupertinoIcons.moon_stars;
  gotToAppPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const App()),
        (Route<dynamic> route) => false);
  }

  logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await globals.getSharedPreferences();
    gotToAppPage();
  }

  return AppBar(
    leading: const BackButton(
      color: Colors.black87,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        key: const Key('lightDarkModeIcon Student'),
        color: Colors.black87,
        icon: const Icon(lightDarkModeIcon),
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
                      logOut();
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
