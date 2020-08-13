import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> food;

  Detail(this.food);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('back event');
        Navigator.pop(context, 'nothing'); // will go back
        return Future.value(false); // it must return a false if not it will pop the root page
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(food['title'] + ' Detail'),
        ),
        body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(food['image']),
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
                    onPressed: () => Navigator.pop(context, 'remove'),
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
