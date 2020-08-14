import 'package:firstfluttertest/pages/foods/detail.dart';
import 'package:firstfluttertest/pages/foods/manage.dart';
import 'package:flutter/material.dart';

class FoodModel extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;
  final Function _addFood;
  final Function _deleteFood;
  final Function _editFood;

  FoodModel(this._foods, this._addFood, this._deleteFood, this._editFood);

  Widget _addButton(context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        _addFood({
          'title': 'bryani',
          'description': 'description',
          'image': 'assets/food.jpg',
          'price': '12'
        });
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
              Text(_foods[index]['description']),
              Text(_foods[index]['price'].toString()),
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
                                      DetailPage(_foods[index])))
                          .then((String action) {
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
    print('[FoodModel State] build()');
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Chose'),
            ),
            ListTile(
              title: Text('Manage Foods'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ManagePage(_addFood, _editFood, _foods);
                }));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Food list'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: _addButton(context),
          ),
          Expanded(child: _renderList())
        ],
      ),
    );
  }
}
