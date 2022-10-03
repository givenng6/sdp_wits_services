import 'package:flutter/material.dart';
import '../Buses/BusObject.dart';
import '../Dining/DiningObject.dart';

class Subscriptions with ChangeNotifier{
  List<String> _subs = [];
  List<String> _busFollowing = [];
  List<BusObject> _busSchedule = [];
  String _dhFollowing = "";
  List<DiningObject> _diningHalls = [];
  String _mealTime = "";

  List<String> get subs => _subs;
  List<String> get busFollowing => _busFollowing;
  List<BusObject> get busSchedule => _busSchedule;

  void addSub(String service){
    _subs.add(service);
    notifyListeners();
  }

  void updateBusFollowing(List<String> busFollowing){
    _busFollowing = busFollowing;
    notifyListeners();
  }

  void setBusSchedule(List<BusObject> busSchedule){
    _busSchedule = busSchedule;
    notifyListeners();
  }

  void updateDHFollowing(String dhFollowing){
    _dhFollowing = dhFollowing;
    notifyListeners();
  }

  void setDiningHalls(List<DiningObject> diningHalls){
    _diningHalls = diningHalls;
    notifyListeners();
  }

  void setMealTime(String meal){
    _mealTime = meal;
    notifyListeners();
  }



}