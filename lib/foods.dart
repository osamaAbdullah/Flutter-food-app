import 'package:firstfluttertest/add_food.dart';
import 'package:flutter/material.dart';

import './food_list.dart';

class Foods extends StatefulWidget {
  final String startingFood;

  Foods({this.startingFood = 'Default'}) {
    print('[FoodManager Widget] Constructor');
  }

  @override
  State<StatefulWidget> createState() {
    return _FoodsState();
  }
}

class _FoodsState extends State<Foods> {
  List<String> _foods = [];

  @override
  void initState() {
    print('[FoodManager State] initState()');
    _foods.add(widget.startingFood);
    super.initState();
  }

  @override
  void didUpdateWidget(Foods oldWidget) {
    print('[FoodManager State] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addFood(String food) {
    setState(() {
      _foods.add(food);
    });
    print(_foods);
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
        Expanded(child: FoodList(_foods))
      ],
    );
  }
}
