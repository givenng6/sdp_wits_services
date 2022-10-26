class EventObject{

  String _eventTitle = "";
  String _eventID  = "";
  String _venue = "";
  String _type = "";
  String _date = "";
  String _time = "";
  String? _url = null;
  List<String> _likes = [];

  String get eventTitle => _eventTitle;
  String get eventID => _eventID;
  String get venue => _venue;
  String get type => _type;
  String get date => _date;
  String get time => _time;
  String? get url => _url;
  List<String> get likes => _likes;

  EventObject(String eventTitle, String date, String time, List<String> likes, String venue, String type, String eventID, String? url){
    _venue = venue;
    _eventID = eventID;
    _eventTitle = eventTitle;
    _date = date;
    _time = time;
    _type = type;
    _likes = likes;
    _url = url;
  }

  void addLike(String email){
    _likes.add(email);
  }



}