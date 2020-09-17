import 'dart:convert';

import 'package:firstfluttertest/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  List<User> _users;

  User _authenticatedUser;

  User get authenticatedUser {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final http.Response response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAiCTN0ZfzFZxJRpu56jcIHXmEkrVIG6Mk',
        body: json.encode({'email': email, 'password': password, 'returnSecureToken': true}),
        headers: {'Content-Type': 'application/json'});
    Map<String, dynamic> res = json.decode(response.body);
    _authenticatedUser =
        User(id: res['localId'], email: res['email'], token: res['idToken']);
    print(_authenticatedUser.id);
    print(_authenticatedUser.email);
    print(_authenticatedUser.token);
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
    _authenticatedUser =
        User(id: res['localId'], email: res['email'], token: res['idToken']);
    print(_authenticatedUser.id);
    print(_authenticatedUser.email);
    print(_authenticatedUser.token);
    return res.containsKey('idToken')
        ? {'message': 'Success'}
        : {
            'message': 'Something went wrong!',
            'error': res['error']['message']
          };
  }
}
