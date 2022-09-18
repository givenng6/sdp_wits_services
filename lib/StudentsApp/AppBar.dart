import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{
  const MyAppBar({Key? key, @required title}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(0, 45, 0, 15),
        decoration: const BoxDecoration(
            color: Color(0xff003b5c)
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Title", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
          ],
        )

    );
  }
}