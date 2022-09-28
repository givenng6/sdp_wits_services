import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Events extends HookWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Events'), backgroundColor: Color(0xff003b5c),),
      body: Column(
        children: [
          Text('data')
        ],
      ),
    );
  }
}