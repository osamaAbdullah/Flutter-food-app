import 'package:firstfluttertest/pages/foods/manage.dart';
import 'package:flutter/material.dart';

import '../foods.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    return Manage();
                  }));
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Food list'),
        ),
        body: Foods(),
      );
  }
}
