import 'package:flutter/material.dart';

import 'addEvent.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: const Color(0xff003b5c),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                    child: Image.asset('assets/events_hack.jpeg'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('date',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey)),
                            Text('time',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey))
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'eventTitle',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                backgroundColor: const Color(0xff003b5c),
                                shape: const StadiumBorder()),
                            onPressed: () {
                              // if (!likes.contains(email)) {
                              //   // TODO add like
                              //   for (int i = 0; i < events.length; i++) {
                              //     String id = events[i].eventID;
                              //     if (id == eventID) {
                              //       context.read<Subscriptions>().likeEvent(email, i);
                              //       addLike(context, email, eventID);
                              //       break;
                              //     }
                              //   }
                              // }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                'Interested on the event',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 10.0,),
                              Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Colors.white,
                              )
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              addOns("LIKES", '20'),
                              addOns("VENUE", 'MSL'),
                              addOns("TYPE", 'Hackathon')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 40.0,
        width: 130.0,
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
          child: Row(
            children: const <Widget>[
              Spacer(),
              Icon(Icons.add),
              Spacer(),
              Text('Add Event'),
              Spacer()
            ],
          ),
        ),
      ),
    );
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
}
