import 'package:flutter/material.dart';

class AddFood extends StatelessWidget {
  final Function _addFood;
  AddFood(this._addFood);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        _addFood('Sweets');
      },
      child: Text('Add Product'),
    );
  }}