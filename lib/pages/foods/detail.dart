import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> food;

  DetailPage(this.food);

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('back event');
        Navigator.pop(context, 'nothing'); // will go back
        return Future.value(
            false); // it must return a false if not it will pop the root page
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(food['title'] + ' Detail'),
        ),
        body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Image.asset(food['image']),
              onTap: () {
                print('you taped');
              },
            ),
            Container(
                padding: EdgeInsets.all(10.0),
                child: Text('\$' + food['price'])),
            Container(
                padding: EdgeInsets.all(10.0), child: Text(food['title'])),
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
