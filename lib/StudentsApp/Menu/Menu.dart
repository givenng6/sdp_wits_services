import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './MenuAppBar.dart';
import './MenuItems.dart';


class Menu extends HookWidget {

  String email = "", username = "";
  var nSubs = [];
  var subs = useState([]);
  Menu(this.email, this.username, this.nSubs,{Key? key}) : super(key: key){
    subs.value = nSubs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           MenuAppBar(email, username, subs),
           MenuItems(email, username, subs)
        ],
      ),
    );
  }
}