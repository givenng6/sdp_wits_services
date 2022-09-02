import 'package:flutter/material.dart';
import 'model/userInfo.dart';
import 'model/userDetails.dart';
import 'customWIdgets/appBarWidget.dart';
import 'customWIdgets/buttonWidget.dart';
import 'customWIdgets/profileWidget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      appBar: BuildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          //under profile widget, dispay the user name
          const SizedBox(height: 24),
          buildName(user),
          Center(child: buildSubscriptionButton()),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(children: [
        Text(user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 4),
        Text(user.email, style: TextStyle(color: Colors.grey))
      ]);

  Widget buildSubscriptionButton() => ButtonWidget(
        text: 'View Subscriptions',
        onClicked: () {},
      );
  Widget buildAbout(User user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('About')],
      ));
}
