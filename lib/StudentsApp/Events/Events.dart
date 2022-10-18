import 'package:flutter/material.dart';

class Events extends StatefulWidget{
  @override
  State<Events> createState() => _Events();
}

class _Events extends State<Events>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Events'), backgroundColor: Color(0xff003b5c),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            eventCard("Wits FC vs Bidvest Wits - Home game ", "12/11/2022", "13:00", "211", "Wits Stadium", 'Sport'),
            eventCard("Wits Intercampus Hackathon 2022 - DLU", "06/10/2022", "09:00", "3", "WSS", 'Hackathon'),
            eventCard("Joyers Celebration", "12/11/2022", "13:00", "54", "Wits Stadium", 'Religion')
          ],
        ),
      )
    );
  }

  Widget eventCard(String eventTitle, String date, String time, String likes, String venue, String type){
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
      default:
        img = "assets/events_sport.png";
        buttonColor = const Color(0xff86B049);
        isDark = false;
        break;
    }


    return Card(
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
                      Text(date),
                      Text(time)
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
                      onPressed: (){},
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
                        addOns("LIKES", likes),
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

}