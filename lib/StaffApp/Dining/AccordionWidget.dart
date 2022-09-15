import 'dart:convert';
import './selectBeakfastPage.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'Package.dart';

class AccordionWidget extends StatefulWidget {
  final List<Package> packages;
  //final List<Package> selected; ->associated with line 17 and 38 
  final String type;
  AccordionWidget(
      {Key? key,
      required this.packages,
      //required this.selected,
      required this.type})
      : super(key: key);

  @override
  State<AccordionWidget> createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum = "cgcgcujcgx h";
  List<AccordionSection> accordionSections = [];
  List<Package> selectedPackages = [];

  @override
  void initStage() {
    //selectedPackages = widget.selected;
    //TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String buildItemListAsString(Package package) {
      String stringOfItems = "";
      for (int i = 0; i < package.items.length; i++) {
        stringOfItems = stringOfItems + package.items[i] + ", ";
      }
      return stringOfItems;
    }
    return Scaffold(
      body: Accordion(
        maxOpenSections: 1,
        headerBackgroundColorOpened: Colors.black54,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        children: widget.packages
            .map((package) => AccordionSection(
                  isOpen: false,
                  //leftIcon:
                  headerBackgroundColor: selectedPackages.contains(package)
                      ? Colors.green
                      : Colors.blue,
                  headerBackgroundColorOpened: Colors.blue,
                  header: Text(package.packageName, style: _headerStyle),
                  content: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(buildItemListAsString(package)),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: selectedPackages.contains(package)
                              ? Icon(Icons.check_circle_sharp)
                              : Icon(Icons.check_circle_outline_outlined),
                          onTap: () {
                            debugPrint("${selectedPackages.contains(package)}");
                            setState(() {
                              if (selectedPackages.contains(package)) {
                                selectedPackages.remove(package);
                              } else {
                                selectedPackages.add(package);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                  // onOpenSection: () => print('onOpenSection ...'),
                  // onCloseSection: () => print('onCloseSection ...'),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Map<String, dynamic> data = {
              "dhName": "DH1",
              "type": widget.type,
              "selected": selectedPackages
            };

            var req = await http.post(Uri.parse(""),
                headers: <String, String>{
                  "Accept": "application/json",
                  "Content-Type": "application/json; charset=UTF-8"
                },
                body: jsonEncode(data));

            var res = await jsonDecode(req.body);

            if (res["status"] == "all good") {
              debugPrint("$res");
            }
          },
          child: Icon(Icons.save_alt_sharp)),
    );
  }
}
