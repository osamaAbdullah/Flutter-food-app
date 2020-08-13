import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  final List <String> _products;

  FoodList(this._products);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _products
          .map(
            (element) => Card(
          child: Column(
            children: <Widget>[
              Image.asset('assets/food.jpg'),
              Text(element)
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}