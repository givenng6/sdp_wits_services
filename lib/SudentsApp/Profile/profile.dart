import 'package:flutter/material.dart';
import 'package:Profile/model/user.dart';
import './custom_widgets/appbar_widget.dart';
import './utils/user_preferences.dart';
import './custom_widgets/profile_widget.dart';

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
          const SizedBox(height: 50),
          Center(
            child: Text('Subscriptions'),
          ),
          buildListView(),
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
  Widget buildListView() {
    final List<String> entries = <String>[
      'Bus Scedule',
      'Events',
      'Campus Control',
      'Wits Meals',
      'Bus Scedule',
      'Events',
    ];
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Color.fromARGB(255, 0, 70, 225),
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        });
  }
}
