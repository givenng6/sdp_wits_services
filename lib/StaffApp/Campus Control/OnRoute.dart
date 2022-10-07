import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/onDuty.dart';

import 'Skeleton.dart';

class OnRoute extends StatefulWidget {
  const OnRoute({Key? key}) : super(key: key);

  @override
  State<OnRoute> createState() => _OnRouteState();
}

class _OnRouteState extends State<OnRoute> {
  List<String> destinations = [
    "Student Digz",
    "campus Africa 49",
    "campus Africa 56",
    "J-One",
    "South Point Braam center",
    "Dakalo"
  ];

  List<String> done = []; // covered destinations

  void handleCard(int index) {
    String curr = destinations[index];
    setState(() {
      if (done.contains(curr)) {
        done.remove(curr);
      } else {
        done.add(curr);
      }
    });
  }

  void handleMove() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => OnDuty()));
  }

  SliverChildBuilderDelegate ItemList() {
    return SliverChildBuilderDelegate(
        childCount: destinations.length,
        (context, index) => Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: ListTile(
                tileColor: done.contains(destinations[index])
                    ? Colors.grey
                    : const Color(0xff003b5c),
                onTap: () {
                  handleCard(index);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: Text(
                  destinations[index],
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
      floatingActionButton: destinations.length != done.length
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
