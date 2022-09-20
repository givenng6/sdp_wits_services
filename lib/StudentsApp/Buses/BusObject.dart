// data structure to sort bus schedule...

class BusObject {

  String routeName = "";
  String id = "";
  String status = "";
  String position = "";
  List<dynamic> stops = [];
  BusObject(this.routeName, this.id, this.stops, this.status, this.position);

  String getID(){
    return id;
  }

  String getStatus(){
    return status;
  }

  String getPosition(){
    return position;
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