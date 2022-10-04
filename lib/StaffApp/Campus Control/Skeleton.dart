import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/OnRoute.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/onDuty.dart';

class Skeleton extends StatefulWidget {
  final String name;
  final String btnAction;
  final Widget itemsList;

  const Skeleton({
    Key? key,
    required this.name,
    required this.btnAction,
    required this.itemsList,
  }) : super(key: key);

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff003b5c),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: const <Widget>[
            Icon(
              Icons.security,
              color: Color(0xff003b5c),
            ),
            SizedBox(width: 8.0),
            Text("Campus Control", style: TextStyle(color: Color(0xff003b5c)))
          ],
        ),
        actions: const <Widget>[
          CircleAvatar(
              backgroundColor: Color(0xff003b5c),
              child: Text(
                "L",
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ))
        ],
      ),
      floatingActionButton: Container(
        width: 130.0,
        height: 40.0,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xff003b5c))),
          onPressed: () {
            if (widget.name == "Next Stuff") {
              // Navigator.pushReplacementNamed(context, "/OnRoute");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OnRoute()));
            } else if (widget.name == "Destination") {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OnDuty()));

            }
          },
          child: Row(
            children: <Widget>[
              Text(
                widget.btnAction,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(width: 4.0),
              const Icon(
                Icons.navigate_next,
                size: 40.0,
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 150.0,
                child: Center(
                  child: Text(
                    widget.name,
                    style: const TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(flex: 4, child: widget.itemsList)
          ],
        ),
      ),
    );
  }
}
