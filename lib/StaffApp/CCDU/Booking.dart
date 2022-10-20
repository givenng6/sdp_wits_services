class Booking{
  late String name, date, time, description, type,location,link;

  Booking({required this.type,required obj}){
    name = obj['creator'];
    time = obj['time'];
    date = obj['date'];
    description = obj['description'];
    location = obj['location'];

  }

  void setLink(String link){
    this.link = link;
  }


}