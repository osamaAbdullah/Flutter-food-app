import 'package:flutter/material.dart';

class ListFoods extends StatelessWidget {
  final List<Map<String, dynamic>> foods;

  ListFoods({this.foods});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Text('List of foods')),
      ],
    );
  }
}
