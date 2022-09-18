

class DiningObject{
  String name = "";
  String id = "";
  List<dynamic> bfA;
  List<dynamic> bfB;
  List<dynamic> bfC;

  List<dynamic> lA;
  List<dynamic> lB;
  List<dynamic> lC;

  List<dynamic> dA;
  List<dynamic> dB;
  List<dynamic> dC;

  DiningObject(this.name, this.id, this.bfA, this.bfB, this.bfC, this.lA, this.lB, this.lC, this.dA, this.dB, this.dC);

  String getDiningName(){
    return name;
  }

  String getID(){
    return id;
}

}