import 'package:flutter/material.dart';

class AddFood extends StatelessWidget {
  final Function _addFood;
  AddFood(this._addFood);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        _addFood({'title': 'bryani', 'image': 'assets/food.jpg', 'price': '12'});
      },
      child: Text('Add Product'),
    );
  }}