import 'package:flutter/material.dart';

class ListTab extends StatelessWidget {
  final List<Map<String, dynamic>> foods;

  ListTab({this.foods});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Text('List of foods')),
      ],
    );
  }
}
