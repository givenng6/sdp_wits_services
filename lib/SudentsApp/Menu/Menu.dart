import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './MenuAppBar.dart';
import './MenuItems.dart';


class Menu extends HookWidget {

  String email = "", username = "";
  Menu(this.email, this.username, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex:1,child: MenuAppBar(email, username)),
          Expanded(flex:3,child: MenuItems())
        ],
      ),
    );
  }
}