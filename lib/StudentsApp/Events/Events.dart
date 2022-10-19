import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Events/events_object.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';


class Events extends StatefulWidget{
  @override
  State<Events> createState() => _Events();
}

class _Events extends State<Events>{
  List<EventObject> events = [];

  @override
  Widget build(BuildContext context){
    events = context.watch<Subscriptions>().events;
    return Scaffold(
      appBar: AppBar(title: const Text('Events'), backgroundColor: Color(0xff003b5c),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           showEvents()
          ],
        ),
      )
    );
  }

  Widget eventCard(String eventTitle, String date, String time, List<String> likes, String venue, String type, String eventID){
    String img = "";
    Color buttonColor;
    bool isDark;

    switch(type){
      case "Sport":
        img = "assets/events_sport.png";
        buttonColor = const Color(0xff86B049);
        isDark = true;
        break;
      case "Hackathon":
        img = 'assets/events_hack.jpeg';
        buttonColor = const Color(0xff000000);
        isDark = true;
        break;
      case "Religion":
        img = "assets/events_religion.jpeg";
        buttonColor = const Color(0xffff7700);
        isDark = true;
        break;
      case "Awareness":
        img = "assets/events_awareness.jpeg";
        buttonColor = const Color(0xffe5e4e2);
        isDark = false;
        break;
      case "Concert":
        img = "assets/events_concert.jpeg";
        buttonColor = const Color(0x80b0c4de);
        isDark = false;
        break;
      case "Entertainment":
        img = "assets/events_entertainment.jpeg";
        buttonColor = const Color(0xff1974d2);
        isDark = true;
        break;
      case "Politics":
        img = "assets/events_politics.jpeg";
        buttonColor = const Color(0x801e69cf);
        isDark = true;
        break;
      default:
        img = "assets/events_other.jpeg";
        buttonColor = const Color(0xfff8ed62);
        isDark = false;
        break;
    }


    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)
                ),
                child: Image.asset(img),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(date, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
                        Text(time, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(eventTitle, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: buttonColor,
                            shape: const StadiumBorder()
                        ),
                        onPressed: (){
                          print(eventID);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isDark ?
                            Row(
                              children: const [
                                Text('Interested on the event', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                                Icon(Icons.open_in_new, color: Colors.white,)
                              ],
                            )
                            :
                            Row(
                              children: const [
                                Text('Interested on the event', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),),
                                Icon(Icons.open_in_new, color: Colors.black,)
                              ],
                            )
                          ],
                        )
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          addOns("LIKES", likes.length.toString()),
                          addOns("VENUE", venue),
                          addOns("TYPE", type)
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
      ),
    );
  }

  Widget addOns(String title, String size){
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
        Text(size, style: const TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget showEvents(){
    List<Widget> items = [];

    for(EventObject event in events){
      items.add(eventCard(event.eventTitle, event.date, event.time, event.likes, event.venue, event.type, event.eventID));
    }

    return Column(children: items);
  }

}