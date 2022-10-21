import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../Controllers/feed_controller.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String uri = 'https://sdpwitsservices-production.up.railway.app/';

  // String uri = 'http://192.168.20.17:5000/';
  double initialChildSize = 0.6;
  double minChildSize = 0.4;
  double maxChildSize = 0.95;

  File? image;

  late StreamSubscription<bool> _keyboardSubscription;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();

    _keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) async {
      if (visible) {
        initialChildSize = 0.95;
      } else {
        initialChildSize = 0.6;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardSubscription.cancel();
  }

  final feedController = Get.find<FeedController>();

  Widget postButtonChild = const Text(
    'Post',
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  );
  Widget dateButtonChild = const Text(
    'Event Date',
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  );
  Widget timeButtonChild = const Text(
    'Event Time',
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  );

  post() async {
    String uuid = const Uuid().v1();
    String? imageUrl;

    if (image != null) {
      String filename = image!.path;
      Uint8List? file = await image!.readAsBytes();
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child('files/$filename/')
          .putData(file);

      task.whenComplete(() async {
        final storageRef = FirebaseStorage.instance.ref();
        imageUrl = await storageRef.child('files/$filename/').getDownloadURL();
      }).then((_) async {
        Map<String, dynamic> event = {
          'title': title,
          'venue': venue,
          'type': value,
          'date': date,
          'time': time,
          'id': uuid,
          'likes': [],
          'imageUrl': imageUrl,
        };

        debugPrint(event.toString());

        await http
            .post(Uri.parse("${uri}addEvent"),
                headers: <String, String>{
                  "Accept": "application/json",
                  "Content-Type": "application/json; charset=UTF-8",
                },
                body: jsonEncode(<String, Map>{'event': event}))
            .then((_) => Get.back());
      });
    } else {
      Map<String, dynamic> event = {
        'title': title,
        'venue': venue,
        'type': value,
        'date': date,
        'time': time,
        'id': uuid,
        'likes': [],
        'imageUrl': imageUrl,
      };

      debugPrint(event.toString());

      await http
          .post(Uri.parse("${uri}addEvent"),
              headers: <String, String>{
                "Accept": "application/json",
                "Content-Type": "application/json; charset=UTF-8",
              },
              body: jsonEncode(<String, Map>{'event': event}))
          .then((_) => Get.back());
    }
  }

  bool isButtonEnabled = true;

  List<String> types = [
    'Sport',
    'Religion',
    'Hackathon',
    'Awareness',
    'Concert',
    'Entertainment',
    'Politics',
    'Other'
  ];

  String? value;
  String date = '', time = '', title = '', venue = '';

  @override
  Widget build(BuildContext context) {
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        builder: (_, controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0))),
          child: ListView(
            controller: controller,
            children: [
              InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Color(0xff003b5c),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Add Poster (Optional)',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () => pickImage(ImageSource.gallery)),
              if (image != null)
                Center(
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0),
                        child: Image.file(
                          image!,
                          // width: 200,
                          height: 200,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              image = null;
                            });
                          },
                          icon: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20.0)),
                              // color: Colors.black,
                              child: const Icon(
                                Icons.cancel_sharp,
                                color: Colors.black,
                                size: 20.0,
                              )))
                    ],
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: const [
                  Icon(Icons.add, color: Colors.grey),
                  Text('Add Title'),
                ],
              ),
              SizedBox(
                height: 30.0,
                child: TextField(onChanged: (text) {
                  title = text;
                }),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: const [
                  Icon(Icons.add, color: Colors.grey),
                  Text('Add Venue'),
                ],
              ),
              SizedBox(
                height: 30.0,
                child: TextField(onChanged: (text) {
                  venue = text;
                }),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: DropdownButton<String>(
                    hint: const Text(
                      'Event Type',
                      style: TextStyle(color: Colors.black),
                    ),
                    isExpanded: true,
                    value: value,
                    items: types
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              key: Key(item),
                              style: const TextStyle(fontSize: 18),
                            )))
                        .toList(),
                    onChanged: (item) =>
                        setState(() => value = item.toString())),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        DateTime? setDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));

                        if (setDate != null) {
                          // update the date
                          setState(() {
                            date = '${setDate.day.toString().padLeft(2, '0')}'
                                '/${setDate.month.toString().padLeft(2, '0')}/${setDate.year}';
                            dateButtonChild = Text(
                              date,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            );
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Center(
                        child: dateButtonChild,
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        TimeOfDay? setTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (setTime != null) {
                          // update time
                          setState(() {
                            time =
                                "${setTime.hour.toString().padLeft(2, '0')}:${setTime.minute.toString().padLeft(2, '0')}";
                            timeButtonChild = Text(
                              time,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            );
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Center(
                        child: timeButtonChild,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 30.0),
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          title = title.trim();
                          venue = venue.trim();
                          if (title.isNotEmpty &&
                              venue.isNotEmpty &&
                              value != null &&
                              date.isNotEmpty &&
                              time.isNotEmpty) {
                            setState(() {
                              postButtonChild =
                                  const CircularProgressIndicator();
                              isButtonEnabled = false;
                            });
                            post();
                          } else {
                            Get.snackbar(
                                'Error', 'Fill in all required information',
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.black);
                          }
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Center(
                    child: postButtonChild,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Get.back(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
          debugPrint(this.image!.path);
        });
      }
      return;
    } on PlatformException catch (e) {
      debugPrint('Failed To Pick Image: $e');
    }
  }
}
