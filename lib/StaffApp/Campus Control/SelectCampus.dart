import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/onDuty.dart';
import 'CampusControlGlobals.dart' as globals;
import 'Skeleton.dart';

class SelectCampus extends StatefulWidget {
  const SelectCampus({Key? key}) : super(key: key);

  @override
  State<SelectCampus> createState() => _SelectCampusState();
}

class _SelectCampusState extends State<SelectCampus> {
  List<String> campuses = globals.campuses;

  int currIndex = -1;

  void handleTap(int index) {
    setState(() {
      if (currIndex == index) {
        currIndex =-1;
      } else {
        currIndex = index;
      }
    });
  }

  void startShift() {
    globals.StartShift(campuses[currIndex]);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const OnDuty()),(Route<dynamic> route) => false);
  }

  SliverChildBuilderDelegate ItemList() {
    return SliverChildBuilderDelegate(
      childCount: campuses.length,
      (context, index) => Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10,
        child: ListTile(
          onTap: () {
            handleTap(index);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          tileColor: index == currIndex ? Colors.grey : const Color(0xff003b5c),
          title: Text(campuses[index],
              style: const TextStyle(fontSize: 25.0, color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeleton(
        itemsList: ItemList(),
        name: 'Select Campus',
        btnAction: '',
      ),
      floatingActionButton: currIndex == -1
          ? null
          : FloatingActionButton(
        backgroundColor: const Color(0xff003b5c),
              onPressed: () {
                startShift();
              },
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
    );
  }
}
