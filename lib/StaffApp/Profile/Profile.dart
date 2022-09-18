import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './appbar_widget.dart';
import './profile_widget.dart';

class Profile extends HookWidget {

  String? username = "", email = "";
  Profile(this.email, this.username, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BuildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: 'https://images.unsplash.com/'
                'photo-1457449940276-e8deed18bfff?ixlib'
                '=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto'
                '=format&fit=crop&w=870&q=80',
            onClicked: () async {},
          ),
          //under profile widget, display the user name
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget buildName() => Column(children: [
    Text(username!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
    const SizedBox(height: 4),
    Text(email!, style: const TextStyle(color: Colors.grey))
  ]);


}
