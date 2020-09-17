import 'package:firstfluttertest/pages/auth/login.dart';
import 'package:firstfluttertest/pages/foods/index.dart';
import 'package:firstfluttertest/scoped_models/foods.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<FoodModel>(
      model: FoodModel(),
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple),
        routes: {
          '/': (BuildContext context) => LoginPage(),
          '/foods': (BuildContext context) => IndexPage(),
        },
      ),
    );
  }
}
