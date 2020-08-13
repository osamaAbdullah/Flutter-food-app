import 'package:flutter/material.dart';

class CreateFood extends StatelessWidget {
  final Function _addFood;

  CreateFood(this._addFood);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Text('Add food')),
      ],
    );
  }
}
