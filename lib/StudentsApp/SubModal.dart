import 'package:flutter/material.dart';

clas SubModal extends StatefulWidget{

  @override
  State<SubModal> createState()=> _SubModal();
}

class _SubModal extends State<SubModal>{

  @override
  Widget build(BuildContext context){
    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Text("Bottom"),
    );
  }
}