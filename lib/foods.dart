import 'package:firstfluttertest/add_food.dart';
import 'package:flutter/material.dart';

import './food_list.dart';

class Foods extends StatefulWidget {
  final Map<String, dynamic> food;

  Foods({this.food});

  @override
  State<StatefulWidget> createState() {
    return _FoodsState();
  }
}

class _FoodsState extends State<Foods> {
  List <Map <String, dynamic>> _foods = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(Foods oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _addFood(Map<String, dynamic> food) {
    setState(() {
      _foods.add(food);
    });
  }

  void _deleteFood(int index) {
    setState(() {
      _foods.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[FoodManager State] build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: AddFood(_addFood),
        ),
        Expanded(child: FoodList(_foods, _deleteFood))
      ],
    );
  }
}
