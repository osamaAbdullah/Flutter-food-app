import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  final List<String> _foods;

  FoodList(this._foods);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context,int index) {
        return Card(
          child: Column(
            children: <Widget>[
              Image.asset('assets/food.jpg'),
              Text(_foods[index])
            ],
          ),
        );
      },
      itemCount: _foods.length,
    );
  }
}
