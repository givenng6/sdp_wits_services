import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/onDuty.dart';
import 'CampusControlGlobals.dart' as globals;

import 'Skeleton.dart';

class OnRoute extends StatefulWidget {
  const OnRoute({Key? key}) : super(key: key);

  @override
  State<OnRoute> createState() => _OnRouteState();
}

class _OnRouteState extends State<OnRoute> {
  void handleCard(int index) {
    String curr = globals.destinations[index];
    setState(() {
      if (!globals.done.contains(curr)) {
        globals.done.add(curr);
        globals.handleArrived(curr);
      }
    });
  }

  void handleMove() {
    globals.selectedStudents.clear();
    globals.students.clear();
    globals.arrived.clear();
    globals.done.clear();
    globals.destinations.clear();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => const OnDuty()));
  }

  SliverChildBuilderDelegate ItemList() {
    return SliverChildBuilderDelegate(
        childCount: globals.destinations.length,
        (context, index) => Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                tileColor: globals.done.contains(globals.destinations[index])
                    ? Colors.grey
                    : const Color(0xff003b5c),
                onTap: () {
                  handleCard(index);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: Text(
                  globals.destinations[index],
                  style: const TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeleton(
          name: "Destinations", btnAction: "Done", itemsList: ItemList()),
      floatingActionButton: globals.destinations.length != globals.done.length
          ? null
          : FloatingActionButton(
              onPressed: () {
                handleMove();
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.send,
                color: Color(0xff003b5c),
              ),
            ),
    );
  }
}
