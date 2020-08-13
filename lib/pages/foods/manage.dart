import 'package:firstfluttertest/pages/home.dart';
import 'package:flutter/material.dart';

import 'create.dart';
import 'list.dart';

class Manage extends StatelessWidget {
  final List<Map<String, dynamic>> foods;

  Manage({this.foods});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Chose'),
              ),
              ListTile(
                title: Text('All Foods'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return HomePage();
                      }));
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Food list'),
          bottom: TabBar(tabs: <Widget>[
            Tab(text: 'Add Food', icon: Icon(Icons.create)),
            Tab(text: 'My Foods', icon: Icon(Icons.list)),
          ],),
        ),
        body: TabBarView(children: <Widget>[
          CreateFood((){}),
          ListFoods(),
        ],),
      ),
    );
  }
}
