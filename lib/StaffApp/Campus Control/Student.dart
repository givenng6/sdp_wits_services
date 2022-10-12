class Student{
  late String name,email,res,status;

  Student(obj){
    name = obj['username'];
    res = obj['to'];
    email = obj['email'];
    status = obj['status'];
  }
}