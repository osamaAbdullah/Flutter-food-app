import 'package:flutter/material.dart';

class CreateTab extends StatelessWidget {
  final Function _addFood;

  CreateTab(this._addFood);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Text('Add food')),
      ],
    );
  }
}
