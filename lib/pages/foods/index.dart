import 'package:firstfluttertest/pages/foods/manage.dart';
import 'package:flutter/material.dart';

import '../../models/food.dart';

class IndexPage extends StatelessWidget {
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
                    return ManagePage();
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
