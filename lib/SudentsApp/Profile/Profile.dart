import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './appbar_widget.dart';
import './profile_widget.dart';

class Profile extends HookWidget {

  String username = "", email = "";
  List<dynamic> subs = [];
  Profile(this.email, this.username, this.subs,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BuildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: 'https://images.unsplash.com/photo-1457449940276-e8deed18bfff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
            onClicked: () async {},
          ),
          //under profile widget, dispay the user name
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 50),
          Center(
            child: Text('Subscriptions', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
          ),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildName() => Column(children: [
        Text(username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 4),
        Text(email, style: TextStyle(color: Colors.grey))
      ]);
  Widget buildListView() {

    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: subs.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            child: Center(child: Text(subs[index])),
          );
        });
  }
}
