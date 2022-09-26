import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_indicator/loading_indicator.dart';
import './DashAppBar.dart';
import './Widgets/BusWidget.dart';
import './Widgets/DiningWidget.dart';
import './Widgets/ProtectionWidget.dart';
import './Widgets/EventsWidget.dart';
import './Widgets/HealthWidget.dart';


class Dashboard extends HookWidget{

  // list of dashboard widgets to show to user...
  final List<Widget> _cards = [];

  // variables for testing...
  var nIsFetching = true;
  var nSubs = [];
  var nBusSchedule = [];
  var nBusFollowing = [];
  var nDiningHalls = [];
  var nDhFollowing = "";
  var nMealTime = "";

  // variables to be passed to other widgets...
  var isFetching = useState(true);
  var subs = useState([]);
  var busSchedule = useState([]);
  var busFollowing = useState([]);
  var diningHalls = useState([]);
  var dhFollowing = useState("");
  var mealTime = useState("");

  // constructor
  // init data...
  Dashboard(this.nIsFetching, this.nSubs, this.nBusSchedule, this.nBusFollowing, this.nDiningHalls, this.nDhFollowing, this.nMealTime, {Key? key}) : super(key: key){
    isFetching.value = nIsFetching;
    subs.value = nSubs;
    busSchedule.value = nBusSchedule;
    busFollowing.value = nBusFollowing;
    diningHalls.value = nDiningHalls;
    dhFollowing.value = nDhFollowing;
    mealTime.value = nMealTime;
  }

  @override
  Widget build(BuildContext context){

    // display all the widgets for the services sub to..
    for(String service in subs.value){
      switch (service){
        case 'bus_service':
          _cards.add(BusWidget(busSchedule, busFollowing));
          break;
        case 'dining_service':
          _cards.add(DiningWidget(diningHalls, dhFollowing, mealTime));
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
              child: isFetching.value ?
              const LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [Colors.blueGrey],
                strokeWidth: 2,
              )
              :
              ListView.builder(
                itemCount: _cards.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return _cards[index];
                }),)
        ],
      ),
    );
  }

  Widget DashHeader(){
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

  Widget SuggestedItem(String title){
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xff003b5c),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        children: [
          _getIcon(title),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white))
        ],
      ),
    );
  }

  // return icon base on title...
  Widget _getIcon(String title){
    switch (title){
      case 'Campus Health':
        return const Icon(Icons.health_and_safety, color: Colors.red, size: 19,);
      case 'Events':
        return const Icon(Icons.event, color: Colors.white, size: 19,);
      case 'CCDU':
        return const Icon(Icons.health_and_safety_outlined, color: Colors.green, size: 19,);
      default:
        return const Icon(Icons.home, color: Colors.white, size: 19, key: Key('HomeIcon'),);
    }
  }
}