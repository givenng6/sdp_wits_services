import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/UserData.dart';
import './appbar_widget.dart';
import './profile_widget.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  String username = "", email = "";
  List<String> subs = [];

  @override
  Widget build(BuildContext context) {
    email = context.watch<UserData>().email;
    username =  context.watch<UserData>().username;
    subs =  context.watch<Subscriptions>().subs;

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
          const Center(
            child: Text(
              'Subscriptions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          buildListView(),
        ],
      ),
    );
  }

  Widget buildName() => Column(children: [
        Text(username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 4),
        Text(email, style: const TextStyle(color: Colors.grey))
      ]);

  Widget buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: subs.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 50,
            child: Center(child: Text(subs[index])),
          );
        });
  }
}
