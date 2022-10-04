import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData with ChangeNotifier{

  String _username = "";
  String _email = "";

  String get username => _username;
  String get email => _email;

  void setUsername(String username){
    _username = username;
    notifyListeners();
  }

  void setEmail(String email){
    _email = email;
    notifyListeners();
  }
}

