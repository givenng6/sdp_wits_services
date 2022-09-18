import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sdp_wits_services/StudentsApp/Buses/Buses.dart';
import 'package:sdp_wits_services/StudentsApp/Menu/Department.dart';


class MenuItems extends HookWidget {
  List<Department> cardNames = [

    Department(title: "Buses", icon: Icons.directions_bus),
    Department(title: "Dining Services", icon: Icons.restaurant),
    Department(title: "Protection", icon: Icons.security),
    Department(title: "Campus Health", icon: Icons.health_and_safety),
    Department(title: "CCDU", icon: Icons.psychology_outlined),
    Department(title: "Events", icon: Icons.event),
  ];

  String email = "", username = "";
  var subs = useState([]);
  MenuItems(this.email, this.username, this.subs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          children: List.generate(
              cardNames.length,
                  (index) => SizedBox(
                  height: 400,
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cardNames[index].icon,
                            size: 50,
                            color: Color(0xff003b5c),
                          ),
                          Text(
                            cardNames[index].title,
                            style: TextStyle(color: Color(0xff003b5c), fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ))),
        ));

    // Container(child: Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: GridView(children: [
    //     InkWell(
    //       onTap: () {
    //         print("hi");
    //       },
    //       child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white,),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text("Buses",style: TextStyle(color: Colors.black,fontSize: 30),),
    //             Icon(Icons.directions_bus,size:50,color:Colors.blue,),
    //           ],),),
    //     ),

    // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white,),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text("Protection",style: TextStyle(color: Colors.black,fontSize: 30),),
    //       Icon(Icons.directions_car,size:50,color:Colors.blue,),
    //
    //     ],),),
    // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white,),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text("Dining Hall",style: TextStyle(color: Colors.black,fontSize: 30),),
    //       Icon(Icons.restaurant,size:50,color:Colors.blue,),
    //
    //     ],),),
    // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white,),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text("CCDU",style: TextStyle(color: Colors.black,fontSize: 30),),
    //       Icon(Icons.chat,size:50,color:Colors.blue,),
    //
    //     ],),),
    // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white,),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text("Campus Health",style: TextStyle(color: Colors.black,fontSize: 20),),
    //       Icon(Icons.healing_outlined,size:50,color:Colors.red,),
    //
    //     ],),),
    // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white,),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text("Events",style: TextStyle(color: Colors.black,fontSize: 30),),
    //       Icon(Icons.event,size:50,color:Colors.blue,),
    //
    //   //     ],),),
    // ],
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisSpacing: 10,crossAxisSpacing: 10),
  }
}
