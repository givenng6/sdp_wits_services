import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import '../DiningGlobals.dart' as globals;
import 'Package.dart';
import 'SelectOptionItems.dart';

/*
* This is the body the the three tabs.
* It returns a accordion widget with three accordion sections
*/

class AccordionWidget extends StatefulWidget {
  final String
      type; // can be breakfast,lunch or dinner to know which page is using this widget.

  AccordionWidget({Key? key, required this.type}) : super(key: key);

  @override
  State<AccordionWidget> createState() => _AccordionWidgetState();
}

class _AccordionWidgetState extends State<AccordionWidget> {
  List<Package> selectedPackages =
      []; // All the packages with the selected items.
  List<Package> packages =
      []; // All the packages with all the items that can be chosen.

  bool first = true;

  String buildItemListAsString(List<String> arr) {
    // Change a list of items from a string list to one string separated by a comma.
    String stringOfItems = "";
    for (int i = 0; i < arr.length; i++) {
      if (i == arr.length - 1) {
        stringOfItems = "$stringOfItems and ${arr[i]}";
        continue;
      }
      stringOfItems = "$stringOfItems${arr[i]}, ";
    }
    return stringOfItems;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Second in build");
    if (first) {
      // make sure we run this block once
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
      body: !globals.ready // While fetching the data show loading animation.
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
                        header: Text(package.packageName,
                            style: const TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
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
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectOptionItems(
                                                package: package,
                                                type: widget.type,
                                              )));
                                  // Wait for the SelectedOptionItems page to return then re render the whole page
                                  // So that we get the updated list of items.
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
