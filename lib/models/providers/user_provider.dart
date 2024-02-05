
import 'package:flutter/material.dart';
import 'package:menu_craft/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel? user){
    _user = user;
    notifyListeners();
  }

  String? get fullName => "${_user?.name} ${_user?.surname}";
  String? get name => _user?.name;
  String? get surname => _user?.surname;
  String? get email => _user?.email;
  String? get initial => "${_user?.name[0]}${_user?.surname[0]}";
}