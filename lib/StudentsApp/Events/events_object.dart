class EventObject{

  String _eventTitle = "";
  String _eventID  = "";
  String _venue = "";
  String _type = "";
  String _date = "";
  String _time = "";
  List<String> _likes = [];

  String get eventTitle => _eventTitle;
  String get eventID => _eventID;
  String get venue => _venue;
  String get type => _type;
  String get date => _date;
  String get time => _time;
  List<String> get likes => _likes;

  void setEvent(String eventTitle, String date, String time, List<String> likes, String venue, String type, String eventID){
    _venue = venue;
    _eventID = eventID;
    _eventTitle = eventTitle;
    _date = date;
    _time = time;
    _type = type;
    _likes = likes;
  }

  void addLike(String email){
    _likes.add(email);
  }



}