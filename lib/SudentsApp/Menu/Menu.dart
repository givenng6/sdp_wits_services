import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './MenuAppBar.dart';
import './MenuItems.dart';


class Menu extends HookWidget {

  String email = "", username = "";
  var subs = useState([]);
  Menu(this.email, this.username, this.subs,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex:1,child: MenuAppBar(email, username, subs)),
          Expanded(flex:3,child: MenuItems(email, username, subs))
        ],
      ),
    );
  }
}