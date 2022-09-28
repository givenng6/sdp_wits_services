import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './MenuAppBar.dart';
import './MenuItems.dart';


class Menu extends HookWidget {

  String email = "", username = "";
  var nSubs = [];
  var subs = useState([]);
  var screenIndex = useState(0);
  Menu(this.email, this.username, this.nSubs, this.screenIndex, {Key? key}) : super(key: key){
    subs.value = nSubs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           MenuAppBar(email, username, subs),
           MenuItems(email, username, subs, screenIndex)
        ],
      ),
    );
  }
}