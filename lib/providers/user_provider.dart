import 'package:aroundix_task/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: ' ',
    fullName: '',
    email: '',
    password: '',
    products: [],
    token: '',
  );

  User get currentUser => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
