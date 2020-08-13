import 'package:firstfluttertest/pages/foods/detail.dart';
import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;
  final Function _deleteFood;

  FoodList(this._foods, this._deleteFood);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            children: <Widget>[
              Image.asset(_foods[index]['image']),
              Text(_foods[index]['title']),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('Details'),
                    onPressed: () {
                      Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Detail(_foods[index])
                          )
                      ).then((String action) {
                        if (action == 'remove') {
                          _deleteFood(index);
                        }
                      });
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
      itemCount: _foods.length,
    );
  }
}
