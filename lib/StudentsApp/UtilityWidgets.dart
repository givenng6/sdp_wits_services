import 'package:flutter/material.dart';

// widgets to be reused across the students app

class UtilityWidget {
  Widget CircularProfile(String username) {
    // getting the first character of the username to display...
    // display the circular badge...
    String char = username[0].toUpperCase();
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      height: 45,
      width: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueGrey,
      ),
      child: Text(char,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25)),
    );
  }

  Widget AppBar(String title) {
    // The app bar to be reused among screens
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 55, 0, 25),
        decoration: const BoxDecoration(color: Color(0xff003b5c)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
            )
          ],
        ));
  }

  Widget NotSubscribed(String title, bool subscribe) {
    return  Container(
      width: double.infinity,
      child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children:[
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const Text("To access this service you must be subscribed"),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: (){
                subscribe = true;
                print(subscribe);
              },
                child: const Text("Subscribe", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),))
          ]
      ),
    );
  }


}
