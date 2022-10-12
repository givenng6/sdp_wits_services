import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdp_wits_services/StudentsApp/Providers/Subscriptions.dart';
import '../Buses/BusObject.dart';
import '../Dining/DiningObject.dart';
import './DashAppBar.dart';
import './Widgets/BusWidget.dart';
import './Widgets/DiningWidget.dart';
import './Widgets/ProtectionWidget.dart';
import './Widgets/EventsWidget.dart';
import './Widgets/HealthWidget.dart';

class Dashboard extends StatefulWidget {
  final bool? isTesting;
  final List<BusObject>? busSchedule;
  final List<String>? busFollowing;
  final String? dhFollowing;
  final String? mealTime;
  final List<DiningObject>? diningHalls;

  const Dashboard({
    super.key,
    this.isTesting,
    this.busSchedule,
    this.busFollowing,
    this.dhFollowing,
    this.diningHalls, this.mealTime,
  });

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  // list of dashboard widgets to show to user...
  final List<Widget> _cards = [];

  List<String> subs = [];

  @override
  Widget build(BuildContext context) {
    set(){
      context.read<Subscriptions>().addSub('bus_service');
      context.read<Subscriptions>().addSub('dining_service');
      context.read<Subscriptions>().addSub('campus_control');
      context.read<Subscriptions>().addSub('health');
      context.read<Subscriptions>().setBusSchedule(widget.busSchedule!);
      context.read<Subscriptions>().updateBusFollowing(widget.busFollowing!);
      context.read<Subscriptions>().updateDHFollowing(widget.dhFollowing!);
      context.read<Subscriptions>().setMealTime(widget.mealTime!);
      context.read<Subscriptions>().setDiningHalls(widget.diningHalls!);
    }
    setForTesting() async {
      await Future.delayed(const Duration(seconds: 1));
      set();
    }

    if (widget.isTesting != null) {
      setForTesting();
    }
    subs = context.watch<Subscriptions>().subs;

    // display all the widgets for the services sub to..
    for (String service in subs) {
      switch (service) {
        case 'bus_service':
          _cards.add(BusWidget());
          break;
        case 'dining_service':
          _cards.add(DiningWidget());
          break;
        case 'campus_control':
          _cards.add(ProtectionWidget());
          break;
        case 'events':
          _cards.add(EventsWidget());
          break;
        case 'health':
          _cards.add(HealthWidget());
          break;
      }
    }

    // conditional rendering
    // show loading view if the data is not ready yet...
    return Scaffold(
      body: Column(
        children: [
          const DashAppBar(),
          DashHeader(),
          Expanded(
            child: _cards.isEmpty
                ? const Center(
                    child: Text(
                      "Dashboard empty",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _cards.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _cards[index];
                    }),
          )
        ],
      ),
    );
  }

  Widget DashHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Suggestions:"),
          //Text("My Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff003b5c), fontSize: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SuggestedItem("Campus Health"),
              SuggestedItem("Events"),
              SuggestedItem("CCDU")
            ],
          )
        ],
      ),
    );
  }

  Widget SuggestedItem(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: const Color(0xff003b5c),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          _getIcon(title),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white))
        ],
      ),
    );
  }

  // return icon base on title...
  Widget _getIcon(String title) {
    switch (title) {
      case 'Campus Health':
        return const Icon(
          Icons.health_and_safety,
          color: Colors.red,
          size: 19,
        );
      case 'Events':
        return const Icon(
          Icons.event,
          color: Colors.white,
          size: 19,
        );
      case 'CCDU':
        return const Icon(
          Icons.health_and_safety_outlined,
          color: Colors.green,
          size: 19,
        );
      default:
        return const Icon(
          Icons.home,
          color: Colors.white,
          size: 19,
          key: Key('HomeIcon'),
        );
    }
  }
}
