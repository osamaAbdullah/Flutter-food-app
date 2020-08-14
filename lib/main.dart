import 'package:firstfluttertest/models/food.dart';
import 'package:firstfluttertest/pages/auth/login.dart';
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
  List<Map<String, dynamic>> _foods = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(MyApp oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _addFood(Map<String, dynamic> food) {
    print('add here executed');
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

  void _editFood(Map<String, dynamic> food, index) {
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
            FoodModel(_foods, _addFood, _deleteFood, _editFood),
      },
    );
  }
}
