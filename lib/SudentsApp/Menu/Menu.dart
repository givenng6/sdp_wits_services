import 'package:flutter/material.dart';
import './MenuAppBar.dart';
import './MenuItems.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex:1,child: MenuAppBar()),
          Expanded(flex:3,child: MenuItems())
        ],
      ),
    );
  }
}