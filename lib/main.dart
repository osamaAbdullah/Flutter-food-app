import 'package:firstfluttertest/models/food.dart';
import 'package:firstfluttertest/pages/auth/login.dart';
import 'package:firstfluttertest/pages/foods/index.dart';
import 'package:flutter/material.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends State<MyApp> {
  List<Food> _foods = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _addFood(Food food) {
    print(food);
    setState(() {
      _foods.add(food);
    });
  }

  void _deleteFood(int index) {
    setState(() {
      _foods.removeAt(index);
    });
  }

  void _editFood(Food food, index) {
    setState(() {
      _foods[index] = food;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/foods': (BuildContext context) =>
            IndexPage(_foods, _addFood, _deleteFood, _editFood),
      },
    );
  }
}
