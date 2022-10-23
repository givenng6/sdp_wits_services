
class RideObject{
  String _status = "";
  String _reg = "";
  String _carName = "";
  String _driver = "";
  String _from = "";
  String _to = "";
  bool _completed = true;

  String get status => _status;
  String get reg => _reg;
  String get carName => _carName;
  String get driver => _driver;
  String get from => _from;
  String get to => _to;
  bool get completed => _completed;

  void setRide(String status, String reg, String carName, String driver, String from, String to, bool completed){
    _status = status;
    _reg = reg;
    _carName = carName;
    _driver = driver;
    _from = from;
    _to = to;
    _completed = completed;
  }


}