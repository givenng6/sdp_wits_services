import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import 'package:sdp_wits_services/globals.dart' as globals;
import 'Accpted.dart';
import 'All.dart';

//CCDU landing page.
class CCDU extends StatefulWidget {
  const CCDU({
    Key? key,
  }) : super(key: key);

  @override
  State<CCDU> createState() => _CCDUState();
}

class _CCDUState extends State<CCDU> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF013152),
            title: Row(
              children: const [
                Icon(Icons.psychology_outlined),
                SizedBox(
                  width: 10.0,
                ),
                Text('CCDU')
              ],
            ),
            centerTitle: true,
            actions: <Widget>[
              InkWell(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF013152),
                      child: Text(
                        globals.username![0],
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Profile(globals.email, globals.username)));
                  })
            ],
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Accepted',
                ),
                Tab(
                  text: 'All',
                ),
              ],
            ),
          ),
          body: const TabBarView(children: [
            Accepted(),
            All()
          ])),
    );
  }
}
