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

  List<Student> vehicles = [
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
    Student(name: "Lindokuhle", res: "Student Digz"),
    Student(name: "Sabelo", res: "Campus Africa 49"),
  ];

  void handleCard(int index){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OnRoute()));
  }

  Widget myList(){
    return Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) => InkWell(
              onTap: (){
                handleCard(index);
              },
              child: Card(
                child: Container(
                  height: 70.0,
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(vehicles[index].name,style: const TextStyle(
                                fontSize: 23.0
                            ),)),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [Text('- ${vehicles[index].res}')],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Skeleton(name: "Next Stuff", btnAction: "Start", itemsList: myList());
  }
}
