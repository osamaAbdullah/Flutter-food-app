import 'dart:async';
import 'dart:convert';

import 'package:firstfluttertest/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Model {
//  List<User> _users;
  Timer _authTimer;
//  PublishSubject<bool> _userSubject = PublishSubject();
  bool isAuthenticated = false;
  User _authenticatedUser;

  User get authenticatedUser {
    return _authenticatedUser;
  }

//  PublishSubject<bool> get userSubject {
//    return _userSubject;
//  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final http.Response response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAiCTN0ZfzFZxJRpu56jcIHXmEkrVIG6Mk',
        body: json.encode({'email': email, 'password': password, 'returnSecureToken': true}),
        headers: {'Content-Type': 'application/json'});
    Map<String, dynamic> res = json.decode(response.body);
    authenticateUserLocally(res);
    return res.containsKey('idToken')
        ? {'message': 'Success'}
        : {
            'message': 'Something went wrong!',
            'error': res['error']['message']
          };
  }

  Future<Map<String, dynamic>> register() async {
    Map<String, dynamic> data = {
      'email': 'osama@aso.com',
      'password': '11111111',
      'returnSecureToken': true
    };
    http.Response response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAiCTN0ZfzFZxJRpu56jcIHXmEkrVIG6Mk',
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'});
    Map<String, dynamic> res = json.decode(response.body);
    authenticateUserLocally(res);
    return res.containsKey('idToken')
        ? {'message': 'Success'}
        : {
            'message': 'Something went wrong!',
            'error': res['error']['message']
          };
  }

  void authenticateUserLocally(Map<String, dynamic> res) async {
    final DateTime expiredTime =
        DateTime.now().add(Duration(seconds: int.parse(res['expiresIn'])));
    _authenticatedUser = User(
        id: res['localId'],
        email: res['email'],
        token: res['idToken'],
        expiredTime: expiredTime.toIso8601String());
    setAuthTimeOut(int.parse(res['expiresIn']));
//    _userSubject.add(true);
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', _authenticatedUser.id);
    preferences.setString('email', _authenticatedUser.email);
    preferences.setString('token', _authenticatedUser.token);
    preferences.setString('expiredTime', expiredTime.toIso8601String());
  }

  Future loadAuthentication() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token');
    if (token != null) {
      final expiredTime = DateTime.parse(preferences.getString('expiredTime'));
      if (expiredTime.isBefore(DateTime.now())) {
        return;
      }
      _authenticatedUser = User(
          id: preferences.getString('id'),
          email: preferences.getString('email'),
          expiredTime: preferences.getString('expiredTime'),
          token: token);
      setAuthTimeOut(expiredTime.difference(DateTime.now()).inSeconds);
      isAuthenticated = true;
    }
  }

  void setAuthTimeOut(int time) {
    _authTimer = Timer(Duration(seconds: time), () {
      logout();
//      Navigator.pushReplacementNamed(context, '/login');
//      _userSubject.add(false);
    });
  }

  void logout() async {
    _authenticatedUser = null;
    isAuthenticated = false;
    _authTimer.cancel();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    preferences.remove('email');
    preferences.remove('id');
    preferences.remove('expiredTime');
//    _userSubject.add(false);
  }
}
