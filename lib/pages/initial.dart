import 'package:firstfluttertest/pages/auth/login.dart';
import 'package:firstfluttertest/pages/foods/index.dart';
import 'package:firstfluttertest/scoped_models/foods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class InitialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Initial();
  }
}

class _Initial extends State<InitialPage> {
//  Function abc;
//  @override
//  void initState() {
//    super.initState();
//
//  }

//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    abc();
//  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, FoodModel model) {
      if (model.isAuthenticated) {
        return IndexPage();
      } else {
        return LoginPage();
      }
    });
  }
}
