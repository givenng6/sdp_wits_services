
class Vehicle{
  late String name;
  late String id;
  late int seats;
  Vehicle(obj){

    name = obj["carName"];
    id = obj["numPlate"];
    seats = obj["seats"];
  }
}