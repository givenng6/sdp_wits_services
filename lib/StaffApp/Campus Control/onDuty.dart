import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/OnRoute.dart';
import 'package:sdp_wits_services/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Skeleton.dart';
import 'Student.dart';
import 'CampusControlGlobals.dart' as globals;

class OnDuty extends StatefulWidget {
  const OnDuty({Key? key}) : super(key: key);

  @override
  State<OnDuty> createState() => _OnDutyState();
}

class _OnDutyState extends State<OnDuty> {
  List<Student> students = [];
  void init()async{
    await globals.GetStudents();
    students = [...globals.students];
    setState(() {

    });
  }
  void init2() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setString("driverState", "onDuty");
  }
  @override
  void initState() {
   init();
   init2();
    super.initState();
  }

  void handleCard(int index) {

  }

  SliverChildBuilderDelegate ItemList() {
    return SliverChildBuilderDelegate(
        childCount: students.length,
        (context, index) => InkWell(
              onTap: () {
                handleCard(index);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 10,
                child: Container(
                  height: 70.0,
                  child: ListTile(
                    tileColor: const Color(0xff003b5c),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                students[index].name,
                                style: const TextStyle(fontSize: 23.0,color: Colors.white),
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [Text('- ${students[index].res}',style: const TextStyle(color: Colors.white),)],
                              )),
                          const SizedBox(height: 5.0,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Skeleton(
          name: "Next Stuff", btnAction: "Start", itemsList: ItemList()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: (){Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => OnRoute()));},
        child: const Text("Start",style: TextStyle(color: Color(0xff003b5c)),),
      ),
    );
  }
}
