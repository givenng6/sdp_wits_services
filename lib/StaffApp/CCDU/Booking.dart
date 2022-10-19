class Booking{
  late String name, email, date, time, description, type;

  Booking({required this.type,required obj}){
    name = obj['name'];


  }
}