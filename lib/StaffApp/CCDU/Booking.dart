class Booking {
  late String name, date, time, description, type, location, link,id;

  Booking({required this.type, required obj}) {
    id = obj['id'];
    name = obj['studentName'];
    time = obj['time'];
    date = obj['date'];
    description = obj['description'];
    location = obj['location'];
  }

  void setLink(String link) {
    this.link = link;
  }
}
