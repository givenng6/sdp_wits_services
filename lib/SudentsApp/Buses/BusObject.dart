// data structure to sort bus schedule...

class BusObject {

  String routeName = "";
  List<dynamic> stops = [];
  BusObject(this.routeName, this.stops);

  // return the current bus route name
  String getRouteName(){
    return routeName;
  }

  // return the current bus list of stops
  List<dynamic> getStops(){
    return stops;
  }

}