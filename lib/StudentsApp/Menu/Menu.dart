import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './MenuAppBar.dart';
import './MenuItems.dart';

class Menu extends StatefulWidget{
  final Function(int index) onNavigate;
  Menu({required this.onNavigate});
  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           MenuAppBar(),
           MenuItems(onNavigate: widget.onNavigate)
        ],
      ),
    );
  }
}