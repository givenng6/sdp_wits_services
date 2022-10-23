
class CCDUObject {

  String _status = "";
  String _time =  "";
  String _date =  "";
  String _description =  "";
  String _counsellor = "";
  String _counsellorName =  "";
  String _location =  "";
  String _id = "";

  String get id => _id;
  String get status => _status;
  String get time => _time;
  String get date => _date;
  String get description => _description;
  String get counsellor => _counsellor;
  String get counsellorName => _counsellorName;
  String get location => _location;

  void setAppointment(String id, String status, String time, String date, String description, String counsellor, String counsellorName, String location){
    _id = id;
    _status = status;
    _time = time;
    _date = date;
    _description = description;
    _counsellor = counsellor;
    _counsellorName = counsellorName;
    _location = location;
  }

}

