import 'package:firstfluttertest/pages/foods/detail.dart';
import 'package:flutter/material.dart';

class FoodModel extends StatefulWidget {
  final Map<String, dynamic> food;

  FoodModel({this.food});

  @override
  State<StatefulWidget> createState() {
    return _FoodModelState();
  }
}

class _FoodModelState extends State<FoodModel> {
  List <Map <String, dynamic>> _foods = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(FoodModel oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _addFood(Map<String, dynamic> food) {
    setState(() {
      _foods.add(food);
    });
  }

  void _deleteFood(int index) {
    setState(() {
      _foods.removeAt(index);
    });
  }

  Widget _addButton() {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        _addFood({'title': 'bryani', 'image': 'assets/food.jpg', 'price': '12'});
      },
      child: Text('Add Product'),
    );
  }

  Widget _renderList() {
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
                      Navigator.push <String> (
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DetailPage(_foods[index])
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

  @override
  Widget build(BuildContext context) {
    print('[FoodManager State] build()');
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: _addButton(),
        ),
        Expanded(child: _renderList())
      ],
    );
  }
}
