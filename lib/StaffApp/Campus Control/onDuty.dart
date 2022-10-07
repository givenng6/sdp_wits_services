import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/OnRoute.dart';
import 'Skeleton.dart';
import 'Student.dart';

class OnDuty extends StatefulWidget {
  const OnDuty({Key? key}) : super(key: key);

  @override
  State<OnDuty> createState() => _OnDutyState();
}

class _OnDutyState extends State<OnDuty> {
  List<Student> students = [
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
  ];

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
