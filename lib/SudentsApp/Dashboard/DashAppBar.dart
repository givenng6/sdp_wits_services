import 'package:flutter/material.dart';

class DashAppBar extends StatelessWidget{
  const DashAppBar({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Image(image: AssetImage("assets/logo.png"), width: 120, height:  50,),

            ],
          )

    );
  }
}