import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Dining/Package.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../DiningGlobals.dart' as globals;

// SelectedOptionItems page
// Shows a list of all the selected items in green then the unselected ones in white

class SelectOptionItems extends StatefulWidget {
  final Package package;
  final String type;

  const SelectOptionItems({Key? key, required this.package, required this.type})
      : super(key: key);

  @override
  State<SelectOptionItems> createState() => _SelectOptionItemsState();
}

class _SelectOptionItemsState extends State<SelectOptionItems> {
  bool showFloatingBtn = false;
  bool loading = false; // show loading animation on the floating button when updating the list.
  List<String> original = [];// Original list of all the items a package can have
  List<String> newList = []; // Newly selected items + the old ones
  List<String> old = []; // Old or items that were already selected.

  @override
  void initState() {
    //By default the old list and new list are the same.
    debugPrint(widget.package.id);
    debugPrint(widget.package.packageName);
    debugPrint("${widget.package.items}");


    if (widget.type == "breakfast") {
      for (int i = 0; i < globals.selectedBreakfast.length; i++) {
        Package item = globals.selectedBreakfast[i];
        if (item.packageName == widget.package.packageName) {
          old = [...item.items];
          newList = [...item.items];
          Package temp = globals.breakfast[i];
          original = [...temp.items];
          break;
        }
      }
    } else if (widget.type == "lunch") {
      for (int i = 0; i < globals.selectedLunch.length; i++) {
        Package item = globals.selectedLunch[i];
        if (item.packageName == widget.package.packageName) {
          old = [...item.items];
          newList = [...item.items];
          Package temp = globals.lunch[i];
          original = [...temp.items];
          break;
        }
      }
    } else {
      for (int i = 0; i < globals.selectedDinner.length; i++) {
        Package item = globals.selectedDinner[i];
        if (item.packageName == widget.package.packageName) {
          old = [...item.items];
          newList = [...item.items];
          Package temp = globals.lunch[i];
          original = [...temp.items];
          break;
        }
      }
    }

    super.initState();
  }

  bool handleTileColor(int index) { // Determines the color if each list item
    if (newList.contains(original[index])) return true;
    return false;
  }

  void handleOnTab(int index) {
    // Called when an item in the list is clicked.
    // if the item item is already in the new list then we remove it
    // else we add it.
    // Toggle each item in the list
    if (newList.contains(original[index])) {
      newList.remove(original[index]);
    } else {
      newList.add(original[index]);
    }

    // Determines whether or not to show the floating action button.
    showFloatingBtn = handleShowFloatingBtn();

  }

  void handleOnPressed() async {
    // called when te floating action button is pressed to confirm that we are changing the list of items for that package.
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, List<String>> selected;

    if (widget.package.packageName == "Option A") {
      selected = {
        "optionA": newList
      };
    } else if (widget.package.packageName == "Option B") {
      selected = {
        "optionB": newList
      };
    } else {
      selected = {
        "optionC": newList
      };
    }

    Map<String, dynamic> data = {// data sent to the backend to update the list of items in a package
      "dhName": sharedPreferences.getString("dhName") as String,
      "type": widget.type,
      "selected": selected
    };

    var req = await http.post(
        Uri.parse("${globals.url}/Menus/SelectedMenu"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(data));

    var res = await jsonDecode(req.body);

    await globals.getMenus();

    Navigator.pop(context); // go back
  }

  bool handleShowFloatingBtn() {
    // Checks if the new list and the old list are different.
    // if they are then we show the floating action button
    // else we don't

    if (newList.length != old.length) return true;

    for (int i = 0; i < newList.length; i++) {
      if (!old.contains(newList[i])) return true;
    }

    return false;
  }

  get itemBuilder => (context, index) => Card( // Card for each list item
        child: ListTile(
          tileColor: handleTileColor(index) ? Colors.green : Colors.white,
          onTap: () {
            handleOnTab(index);
            setState(() {});
          },
          title: Text(original[index]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    debugPrint("$showFloatingBtn");
    handleShowFloatingBtn();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF013152),
        title: const Text("Select Items"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: original.length,
        itemBuilder: itemBuilder,
      ),
      floatingActionButton: !showFloatingBtn?null:FloatingActionButton(
        backgroundColor: const Color(0xFF003b5c),
        onPressed: loading?null:() {
          loading  = true;
          setState(() {});
          handleOnPressed();
        },
        child: loading?const CircularProgressIndicator(key:Key('loading'),color: Colors.white,): const Icon(Icons.check),
      ),
    );
  }
}
