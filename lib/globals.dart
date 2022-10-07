library globals;

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? username;
String? email;
String? kind;
String? department;

Future getSharedPreferences() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  username = sharedPreferences.getString('username');
  email = sharedPreferences.getString('email');
  kind = sharedPreferences.getString('kind');
  department = sharedPreferences.getString('department');
  debugPrint('called');
  // debugPrint(email);
  // debugPrint(username);
  // debugPrint(kind);
  debugPrint(department);
}