import 'package:firstfluttertest/models/food.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Food _food;

  DetailPage(this._food);

  _showWarning(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You will not be able to undo this action!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Discard'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, 'remove');
                },
              ),
            ],
          );
        });
  }

  Widget _buildAddressPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Union Square, San Francisco',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$' + _food.price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, 'nothing'); // will go back
        return Future.value(
            false); // it must return a false if not it will pop the root page
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_food.title + ' Detail'),
        ),
        body: ListView(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Image.network(_food.image),
              onTap: () {},
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                _food.title,
                style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Oswald'),
              ),
            ),
            _buildAddressPriceRow(),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                _food.description,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Back'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  RaisedButton(
                    color: Colors.red,
                    child: Text('DELETE'),
                    onPressed: () => _showWarning(context),
                  ),
                  RaisedButton(
                    color: Colors.lightGreenAccent,
                    child: Text('Modal'),
                    onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: Text('this is a modal'),
                            );
                          })
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
