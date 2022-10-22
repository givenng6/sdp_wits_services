import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sdp_wits_services/StaffApp/Buses/Controller/buses_controller.dart';
import 'package:sdp_wits_services/StaffApp/Profile/Profile.dart';
import 'package:get/get.dart';

class BusesMain extends StatefulWidget {
  const BusesMain({Key? key}) : super(key: key);

  @override
  State<BusesMain> createState() => _BusesMainState();
}

class _BusesMainState extends State<BusesMain> {
  final busesController = Get.find<BusesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!busesController.isFabVisible.value) {
                setState(() {
                  busesController.isFabVisible(true);
                });
              }
            } else if (notification.direction == ScrollDirection.reverse) {
              if (busesController.isFabVisible.value) {
                setState(() {
                  busesController.isFabVisible(false);
                });
              }
            }
            return true;
          },
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 150.0,
                  collapsedHeight: 60,
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Row(
                      children: const [
                        Icon(
                          Icons.bus_alert,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Buses',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  actions: [
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff003b5c),
                          radius: 22.0,
                          child: Text(
                            busesController.username![0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                    busesController.email,
                                    busesController.username)));
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: busesController.routes.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: busesController.takenRoutes
                                    .contains(busesController.routes[index])
                                ? null
                                : () => setState(
                                    () => busesController.handleCardOnTap(index)),
                            child: Card(
                              color: (index == busesController.tapped)
                                  ? Colors.grey
                                  : const Color(0xFF003b5c),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 15.0),
                                    child: ListTile(
                                      enabled:
                                          busesController.clickingEnabled.value,
                                      title: Center(
                                        child: Text(
                                          busesController.routes[index]['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                      trailing: !busesController.takenRoutes
                                              .contains(
                                                  busesController.routes[index])
                                          ? null
                                          : const Text(
                                              'TAKEN',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: (busesController.isFabVisible.value &&
                busesController.shouldFabBeVisible.value)
            ? SizedBox(
                height: 50.0,
                width: 100.0,
                child: FloatingActionButton(
                  backgroundColor: busesController.fabDecoration.value.color,
                  onPressed: () {
                    busesController.handleFloatingActionButton();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(busesController.fabDecoration.value.text),
                ),
              )
            : null)
    );
  }
}

class FabDecoration {
  late String text;
  late Color color;

  FabDecoration({required this.text, required this.color});
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}