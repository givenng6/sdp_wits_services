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
  // List<Student> students = [];

  void init() async {
    await globals.GetStudents();
    // globals.students = [...globals.students];
    setState(() {});
  }

  void init2() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("driverState", "onDuty");
  }

  @override
  void initState() {
    init();
    init2();
    super.initState();
  }

  bool contains(List<Student> arr,Student curr) {
   for(Student student in arr){
     if(student.email == curr.email){
       return true;
     }
   }
   return false;
  }

  void handleCard(int index) {
    setState(() {
      if(contains(globals.selectedStudents, globals.students[index])){
        globals.selectedStudents.remove(globals.students[index]);
      }else{
        globals.selectedStudents.add(globals.students[index]);
      }
    });
  }

  SliverChildBuilderDelegate ItemList() {
    return SliverChildBuilderDelegate(
        childCount: globals.students.length,
        (context, index) => InkWell(
              onTap: () {
                handleCard(index);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 10,
                child: SizedBox(
                  height: 70.0,
                  child: ListTile(
                    tileColor: contains(globals.selectedStudents,globals.students[index])
                        ? Colors.grey
                        : const Color(0xff003b5c),
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
                                globals.students[index].name,
                                style: const TextStyle(
                                    fontSize: 23.0, color: Colors.white),
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '- ${globals.students[index].res}',
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 5.0,
                          )
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
      body: RefreshIndicator(

        onRefresh: () async{
          await globals.GetStudents();
          setState(() {

          });
        },
        child: Skeleton(
            name: "Next Stuff", btnAction: "Start", itemsList: ItemList()),
      ),
      floatingActionButton: globals.selectedStudents.isEmpty
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () async{
                await globals.SetDestinations();
                globals.OnRoute();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const OnRoute()));
              },
              child: const Text(
                "Start",
                style: TextStyle(color: Color(0xff003b5c)),
              ),
            ),
    );
  }
}
