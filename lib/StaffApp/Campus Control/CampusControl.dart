import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/SelectCampus.dart';
import 'Skeleton.dart';
import 'Vehicle.dart';
import 'CampusControlGlobals.dart' as globals;

class CampusControl extends StatefulWidget {
  const CampusControl({Key? key}) : super(key: key);

  @override
  State<CampusControl> createState() => _CampusControlState();
}

class _CampusControlState extends State<CampusControl> {
  int? currVehicleIndex;
  List<Vehicle> vehicles = [
  ];

  void init()async{
    await globals.GetVehicles();
    setState(() {
      vehicles = [...globals.vehicles];

    });
  }

  @override
  void initState() {
    init();
    super.initState();

  }

  void startShift(){
    globals.vehicle = vehicles[currVehicleIndex!];
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const SelectCampus()));
  }

  void handleCard(int index) {
    setState(() {
      if(currVehicleIndex != index){
        currVehicleIndex = index;
      }else{
        currVehicleIndex = null;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeleton(
        name: "Vehicles",
        btnAction: "Next",
        itemsList: ItemList(),
      ),
      floatingActionButton:currVehicleIndex==null?null: FloatingActionButton(
        onPressed: () {startShift();},
        child: Icon(
          Icons.send,
          color: Color(0xff003b5c),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  SliverChildBuilderDelegate ItemList() {
    return SliverChildBuilderDelegate(
        childCount: vehicles.length,
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    tileColor:index == currVehicleIndex?Colors.grey: const Color(0xff003b5c),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                vehicles[index].name,
                                style: const TextStyle(
                                    fontSize: 23.0, color: Colors.white),
                              )),
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '- ${vehicles[index].id}',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                          SizedBox(
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
}
