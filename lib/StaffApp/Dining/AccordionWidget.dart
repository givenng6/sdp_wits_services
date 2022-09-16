import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:http/http.dart' as http;
import '../DiningGlobals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'Package.dart';



class AccordionWidget extends StatefulWidget {
  final String type;

  const AccordionWidget({Key? key, required this.type}) : super(key: key);

  @override
  State<AccordionWidget> createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);

  List<String> selectedPackages = [];
  List<Package> packages = [];

  bool showFloatingButton = false;
  bool first = true;

  bool listEquals(List<String> a,List<String>b){

    if(a.length != b.length) return false;

    for(int i=0;i<b.length;i++){
      if(!a.contains(b[i])) return false;
    }

    return true;

  }

  @override
  Widget build(BuildContext context) {
    String buildItemListAsString(Package package) {
      String stringOfItems = "";
      for (int i = 0; i < package.items.length; i++) {
        stringOfItems = "$stringOfItems${package.items[i]}, ";
      }
      return stringOfItems;
    }

    if (first) {
      if (widget.type == "breakfast") {
        selectedPackages = [...globals.selectedBreakfast];
        packages = globals.breakfast;
      } else if (widget.type == "lunch") {
        selectedPackages = [...globals.selectedLunch];
        packages = globals.lunch;
      } else {
        selectedPackages = [...globals.selectedDinner];
        packages = globals.dinner;
      }
    }

    if (widget.type == "breakfast") {
      showFloatingButton =
          listEquals(globals.selectedBreakfast, selectedPackages);
    } else if (widget.type == "lunch") {
      showFloatingButton = listEquals(globals.selectedLunch, selectedPackages);
    } else {
      showFloatingButton = listEquals(globals.selectedDinner, selectedPackages);
    }

    return Scaffold(
      body: Accordion(
        maxOpenSections: 1,
        headerBackgroundColorOpened: Colors.black54,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        children: packages
            .map((package) => AccordionSection(
                  isOpen: false,
                  //leftIcon:
                  headerBackgroundColor: selectedPackages.contains(package.id)
                      ? Colors.green
                      : const Color(0xFF013152),
                  contentBorderColor: selectedPackages.contains(package.id)
                      ? Colors.green
                      : const Color(0xFF013152),
                  headerBackgroundColorOpened:
                      selectedPackages.contains(package.id)
                          ? Colors.green
                          : const Color(0xFF013152),
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
                          child: selectedPackages.contains(package.id)
                              ? const Icon(Icons.check_circle_sharp)
                              : const Icon(Icons.check_circle_outline_outlined),
                          onTap: () {
                            setState(() {
                              if (selectedPackages.contains(package.id)) {
                                selectedPackages.remove(package.id);
                              } else {
                                selectedPackages.add(package.id);
                              }

                              first = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 1,
                ))
            .toList(),
      ),
      floatingActionButton: showFloatingButton
          ? null
          : FloatingActionButton(
        backgroundColor: const Color(0xFF013152),
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();

                Map<String, dynamic> data = {
                  "dhName": sharedPreferences.getString("dhName") as String,
                  "type": widget.type,
                  "selected": selectedPackages
                };

                debugPrint("$data");

                var req = await http.post(Uri.parse("${globals.url}/Menus/SelectedMenu"),
                    headers: <String, String>{
                      "Accept": "application/json",
                      "Content-Type": "application/json; charset=UTF-8"
                    },
                    body: jsonEncode(data));

                var res = await jsonDecode(req.body);

                if (res["status"] == "added") {
                  debugPrint("$res");
                  await globals.getMenus();
                  showFloatingButton = true;
                  setState(() {});


                }
              },
              child: const Icon(Icons.check)),
    );
  }
}
