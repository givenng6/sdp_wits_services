import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Controllers/events_controller.dart';
import 'addEvent.dart';
import 'package:sdp_wits_services/globals.dart' as globals;

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final eventsController = Get.find<EventsController>();

  String imageUrl = '';
  bool viewing = false;

  double opacity = 1;

  String email = globals.email!;

  double fabWidth = 130.0;

  late Widget initFabChild = Row(
        children: const <Widget>[
          Spacer(),
          Icon(Icons.add),
          Spacer(),
          Text('Add Event'),
          Spacer()
        ],
      ),
      fabChild;

  @override
  void initState() {
    fabChild = initFabChild;
    super.initState();
  }

  addText() async{
    await Future.delayed(const Duration(milliseconds: 100));
    setState(()=>fabChild = initFabChild);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: const Color(0xff003b5c),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          setState(() {
            if (notification.metrics.pixels > 120 &&
                notification.direction == ScrollDirection.reverse) {
              fabWidth = 40.0;
              fabChild = const Icon(Icons.add);
            }
            if (notification.direction == ScrollDirection.forward) {
              fabWidth = 130.0;
              addText();
            }
          });

          return true;
        },
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () => eventsController.getEvents(),
            child: ListView.builder(
                key: const PageStorageKey<String>('page'),
                itemCount: eventsController.events.length,
                itemBuilder: (context, index) {
                  String img =
                      getImageForType(eventsController.events[index]['type']);
                  String date = eventsController.events[index]['date'];
                  String? imgUrl = eventsController.events[index]['imageUrl'];
                  String time = eventsController.events[index]['time'];
                  String title = eventsController.events[index]['title'];
                  String venue = eventsController.events[index]['venue'];
                  String type = eventsController.events[index]['type'];
                  String id = eventsController.events[index]['id'];
                  List likes = eventsController.events[index]['likes'].toList();
                  bool isLiked = eventsController.events[index]['likes']
                      .toList()
                      .contains(email);
                  return Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              imgUrl == null
                                  ? ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                      child: Image.asset(img),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        showImageViewer(context,
                                            CachedNetworkImageProvider(imgUrl),
                                            swipeDismissible: true,
                                            useSafeArea: true);
                                      },
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(20.0)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    CachedNetworkImageProvider(
                                                        imgUrl))),
                                      ),
                                    ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(date,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey)),
                                        Text(time,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        title,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(40),
                                            backgroundColor:
                                                const Color(0xff003b5c),
                                            shape: const StadiumBorder()),
                                        onPressed: () {
                                          if (!likes.contains(email)) {
                                            setState(() {
                                              eventsController.events[index]
                                                      ['likes']
                                                  .add(email);
                                              like(id, true);
                                            });
                                          } else {
                                            setState(() {
                                              eventsController.events[index]
                                                      ['likes']
                                                  .remove(email);
                                              like(id, false);
                                            });
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Interested on the event',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Icon(
                                              !isLiked
                                                  ? Icons.thumb_up_alt_outlined
                                                  : Icons.thumb_up_alt_rounded,
                                              color: Colors.white,
                                            )
                                          ],
                                        )),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 12, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: addOns("INTERESTED",
                                                  likes.length.toString())),
                                          Expanded(
                                              child: addOns("VENUE", venue)),
                                          Expanded(child: addOns("TYPE", type))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: AnimatedContainer(
        height: 40.0,
        width: fabWidth,
        duration: const Duration(milliseconds: 100),
        child: FloatingActionButton(
          backgroundColor: const Color(0xff003b5c),
          onPressed: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => const AddPost()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          child: fabChild,
        ),
      ),
    );
  }

  getImageForType(String type) {
    switch (type) {
      case "Sport":
        return "assets/events_sport.png";
      case "Hackathon":
        return 'assets/events_hack.jpeg';
      case "Religion":
        return "assets/events_religion.jpeg";
      case "Awareness":
        return "assets/events_awareness.jpeg";
      case "Concert":
        return "assets/events_concert.jpeg";
      case "Entertainment":
        return "assets/events_entertainment.jpeg";
      case "Politics":
        return "assets/events_politics.jpeg";
      default:
        return "assets/events_other.jpeg";
    }
  }

  Widget addOns(String title, String size) {
    return Column(
      children: [
        Text(
          title,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(size, style: const TextStyle(fontWeight: FontWeight.bold))
      ],
    );
  }

  like(String id, bool isLiking) async {
    String uri = 'https://sdpwitsservices-production.up.railway.app/';
    // String uri = 'http://192.168.20.17:5000/';
    await http.post(Uri.parse('${uri}like'),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'isLiking': isLiking,
          'email': email,
        }));
  }
}
