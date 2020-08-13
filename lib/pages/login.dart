import 'package:firstfluttertest/pages/home.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text('LOGIN'),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return HomePage();
              }));
            },
          )
        ],
      ),
    );
  }
}
