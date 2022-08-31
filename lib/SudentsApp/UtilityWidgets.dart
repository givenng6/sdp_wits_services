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
        padding: const EdgeInsets.fromLTRB(0, 45, 0, 15),
        decoration: const BoxDecoration(color: Color(0xff003b5c)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ));
  }

  Widget BottomSheet() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          _BottomSheetIcon(),
          const Text(
            "Bus Services",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const Text("Overview"),
          Container(
            height: 280,
            width: double.infinity,
            child: Text("The over view here"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Not Now",
                    style: TextStyle(
                        color: Color(0xff003b5c), fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Subscribe",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _BottomSheetIcon() {
    return Container(
      width: 75,
      height: 75,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: const Icon(
        Icons.bus_alert,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
