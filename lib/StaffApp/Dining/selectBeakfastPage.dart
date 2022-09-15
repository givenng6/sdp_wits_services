import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:accordion/accordion.dart';
import 'AccordionWidget.dart';
import 'Package.dart';

class selectBrakefastPage extends StatefulWidget {
  final DateTime dateTime;
  selectBrakefastPage({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  @override
  State<selectBrakefastPage> createState() => _selectBrakefastPageState();
}

class _selectBrakefastPageState extends State<selectBrakefastPage> {
  @override

  final List<Package> packages = [
    Package(packageName: "Option 1", items: [
      "Item1",
      "Item2",
      "Item3",
      "Item4",
      "Item5",
    ]),
    Package(packageName: "Option 2", items: [
      "Item1",
      "Item2",
      "Item3",
      "Item4",
      "Item5",
    ]),
    Package(packageName: "Option 3", items: [
      "Item1",
      "Item2",
      "Item3",
      "Item4",
      "Item5",
    ]),
    Package(packageName: "Option 4", items: [
      "Item1",
      "Item2",
      "Item3",
      "Item4",
      "Item5",
    ]),
    Package(packageName: "Option 5", items: [
      "Item1",
      "Item2",
      "Item3",
      "Item4",
      "Item5",
    ]),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccordionWidget(packages: packages, type: "breakfast"),
    );
  }
}
