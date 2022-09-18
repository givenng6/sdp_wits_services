import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdp_wits_services/StaffApp/Dining/Package.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../DiningGlobals.dart' as globals;

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
  bool loading = false;
  List<String> original = [];
  List<String> newList = [];
  List<String> old = [];

  @override
  void initState() {
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

  bool handleTileColor(int index) {
    if (newList.contains(original[index])) return true;
    return false;
  }

  void handleOnTab(int index) {
    if (newList.contains(original[index])) {
      newList.remove(original[index]);
    } else {
      newList.add(original[index]);
    }
    showFloatingBtn = handleShowFloatingBtn();

  }

  void handleOnPressed() async {
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

    Map<String, dynamic> data = {
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

    debugPrint("$res");
    await globals.getMenus();

    Navigator.pop(context);
  }

  bool handleShowFloatingBtn() {
    if (newList.length != old.length) return true;

    for (int i = 0; i < newList.length; i++) {
      if (!old.contains(newList[i])) return true;
    }

    return false;
  }

  get itemBuilder => (context, index) => Card(
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
        title: Text("Select Items"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: original.length,
          itemBuilder: itemBuilder,
        ),
      ),
      floatingActionButton: !showFloatingBtn?null:FloatingActionButton(
        backgroundColor: const Color(0xFF003b5c),
        onPressed: loading?null:() {
          loading  = true;
          setState(() {

          });
          handleOnPressed();
        },
        child: loading?const CircularProgressIndicator(color: Colors.white,): const Icon(Icons.check),
      ),
    );
  }
}
