// data structure to sort bus schedule...

class BusObject {

  String routeName = "";
  String id = "";
  List<dynamic> stops = [];
  BusObject(this.routeName, this.id, this.stops);

  String getID(){
    return id;
  }

  // return the current bus route name
  String getRouteName(){
    return routeName;
  }

  // return the current bus list of stops
  List<dynamic> getStops(){
    return stops;
  }

}