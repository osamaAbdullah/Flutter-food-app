import 'package:firstfluttertest/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on Model {
  List<User> _users;

  User _authenticatedUser;

  void login(String email, String password) {
    _authenticatedUser = User(id: 'sfsadfsg', email: email, password: password);
  }
}
