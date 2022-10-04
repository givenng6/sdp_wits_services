import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Campus%20Control/onDuty.dart';
import 'Skeleton.dart';
import 'Vehicle.dart';

class CampusControl extends StatefulWidget {
  const CampusControl({Key? key}) : super(key: key);

  @override
  State<CampusControl> createState() => _CampusControlState();
}

class _CampusControlState extends State<CampusControl> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      name: "Vehicles",
      btnAction: "Next",
      itemsList: ItemList(),
    );
  }
}

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  List<Vehicle> vehicles = [
    Vehicle(id: "CBB 734 EC", name: "Honda"),
    Vehicle(id: "CBB 734 EC", name: "Avanza"),
    Vehicle(id: "CBB 734 EC", name: "Honda"),
    Vehicle(id: "CBB 734 EC", name: "Avanza"),
    Vehicle(id: "CBB 734 EC", name: "Honda"),
    Vehicle(id: "CBB 734 EC", name: "Avanza"),
    Vehicle(id: "CBB 734 EC", name: "Honda"),
    Vehicle(id: "CBB 734 EC", name: "Avanza"),
    Vehicle(id: "CBB 734 EC", name: "Honda"),
  ];

  void handleCard(int index){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const OnDuty()));
  }

  @override
  Widget build(BuildContext context) {
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
                              children: [Text('- ${vehicles[index].id}')],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
