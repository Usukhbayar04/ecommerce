import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // User info
  User? _currentUser;
  User? get currentUser => _currentUser;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<User?> login(String email, String password) async {
    if (kDebugMode) {
      print("LOGIN FUNCTION");
    }
    final response = await Dio().get("https://fakestoreapi.com/users/1");
    if (kDebugMode) {
      print("data is :\n  {$response}");
    }
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.data);
      if (kDebugMode) {
        print('Response Data: $data');
      }
      for (var user in data) {
        if (user['email'] == email && user['password'] == password) {
          if (kDebugMode) {
            print('User authenticated');
          }
          _isLoggedIn = true;
          _currentUser = User.fromJson(user);
          notifyListeners();
          // print('USER IS: ${user.toString()}');
          return _currentUser;
        }
      }
      throw Exception('Invalid email or password');
    } else {
      if (kDebugMode) {
        print('Failed to authenticate. Server error.');
      }
      throw Exception('Failed to authenticate. Server error.');
    }
  }
}
    // "email": "john@gmail.com",
    // "username": "johnd",
    // "password": "m38rmF$",
