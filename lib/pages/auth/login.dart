import 'package:firstfluttertest/scoped_models/foods.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: <Widget>[
          ScopedModelDescendant(
            builder: (BuildContext context, Widget child, FoodModel model) {
              return ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Register'),
                    onPressed: () async {
                      Map<String, dynamic> res = await model.register();
                      if (res['message'] == 'Success') {
                        Navigator.pushReplacementNamed(context, '/foods');
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('An error occured'),
                                content: Text(res['error']),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              );
                            });
                      }
                    },
                  ),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Login'),
                    onPressed: () async {
                      Map<String, dynamic> res =
                          await model.login('osama@aso.com', '11111111');
                      if (res['message'] == 'Success') {
                        Navigator.pushReplacementNamed(context, '/foods');
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('An error occured'),
                                content: Text(res['error']),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )
                                ],
                              );
                            });
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
