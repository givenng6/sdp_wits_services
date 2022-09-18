import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import '../DiningGlobals.dart' as globals;
import 'Package.dart';
import 'SelectOptionItems.dart';

class AccordionWidget extends StatefulWidget {
  final String type;

  const AccordionWidget({Key? key, required this.type}) : super(key: key);

  @override
  State<AccordionWidget> createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);

  List<Package> selectedPackages = [];
  List<Package> packages = [];

  bool showFloatingButton = false;
  bool first = true;
  bool loading = false;


  String buildItemListAsString(List<String> arr) {
    String stringOfItems = "";
    for (int i = 0; i < arr.length; i++) {
      stringOfItems = "$stringOfItems${arr[i]}, ";
    }
    return stringOfItems;
  }

  @override
  Widget build(BuildContext context) {

    if (first) {
      if (widget.type == "breakfast") {
        packages = globals.breakfast;
        selectedPackages = globals.selectedBreakfast;
      } else if (widget.type == "lunch") {
        packages = globals.lunch;
        selectedPackages = globals.selectedLunch;
      } else {
        packages = globals.dinner;
        selectedPackages = globals.selectedDinner;
      }
    }


    return Scaffold(
      body: !globals.ready
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Accordion(
              maxOpenSections: 3,
              headerBackgroundColorOpened: Colors.black54,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              children: packages
                  .map((package) => AccordionSection(
                        isOpen: true,
                        headerBackgroundColor: const Color(0xFF003b5c),
                        contentBorderColor: const Color(0xFF003b5c),
                        headerBackgroundColorOpened: const Color(0xFF003b5c),
                        header: Text(package.packageName, style: _headerStyle),
                        content: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: listItems(package),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: const Icon(Icons.edit),
                                onTap: () async {
                                  var res = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectOptionItems(
                                                  package: package,type: widget.type,)));
                                  debugPrint("hey");
                                  setState(() {});
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
    );
  }

  Widget listItems(Package package) {
    List<String> curr = [];
    for (var item in selectedPackages) {
      {
        if (item.packageName == package.packageName) {
          curr = item.items;
          break;
        }
      }
    }
    return Text(buildItemListAsString(curr));
  }
}
