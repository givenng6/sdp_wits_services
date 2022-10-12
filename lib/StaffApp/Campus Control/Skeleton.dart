import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/CampusControl.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import 'package:sdp_wits_services/globals.dart' as globals;
import 'CampusControlGlobals.dart' as localGlobals;
import 'package:sdp_wits_services/StaffApp/Campus%20Control/OnRoute.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/onDuty.dart';

class Skeleton extends StatefulWidget {
  final String name;
  final String btnAction;
  final SliverChildBuilderDelegate itemsList;

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
  ScrollController customScrollViewController = ScrollController();
  bool load = false;

  void profile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profile(globals.email!, globals.username!)));
  }

  void endShift() async{

    load = true;
    setState(() {

    });
    await localGlobals.EndShift();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (contex) => const CampusControl()));
  }

  void endShiftBottomShit(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) => Container(
              padding: const EdgeInsets.all(15),
              height: 200,
              child:load?const Center(child: CircularProgressIndicator(),): Column(
                children: [
                  const Text("Are you sure you want to end shift?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextButton(
                      onPressed: () {
                        endShift();
                      },
                      child: const Text("End Shift",
                          style: TextStyle(color: Colors.red))),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                ],
              ),
            ));
  }

  var top = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              collapsedHeight: 60,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              flexibleSpace: LayoutBuilder(
                builder: (_, constraints) {
                  top = constraints.biggest.height;
                  debugPrint(top.toString());
                  return AnimatedOpacity(
                    opacity: top >= 130 ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.none,
                      title: Row(
                        children: <Widget>[
                          const SizedBox(width: 8.0),
                          Text(widget.name,
                              style: const TextStyle(color: Color(0xff003b5c)))
                        ],
                      ),
                    ),
                  );
                },
              ),
              centerTitle: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Icon(
                    Icons.security,
                    color: Color(0xff003b5c),
                  ),
                  SizedBox(width: 8.0),
                  Text("Campus Control",
                      style: TextStyle(color: Color(0xff003b5c)))
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              actions: [
                if(widget.name=="Next Stuff")InkWell(
                    onTap: () {
                      endShiftBottomShit(context);
                    },
                    child: Icon(Icons.exit_to_app, color: Colors.red)),
                const SizedBox(
                  width: 10,
                ),

                InkWell(
                  onTap: () {
                    profile();
                  },
                  child: CircleAvatar(
                      backgroundColor: Color(0xff003b5c),
                      child: Text(
                        globals.username![0],
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            SliverList(delegate: widget.itemsList),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
              ),
            )
          ],
        ));
  }
}
