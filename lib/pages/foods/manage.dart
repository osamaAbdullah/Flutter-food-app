import 'package:flutter/material.dart';

import '../../tabs/food/create.dart';
import '../../tabs/food/list.dart';

class ManagePage extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;
  final Function _addFood;
  final Function _editFood;

  ManagePage(this._addFood, this._editFood, this._foods);

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
                  Navigator.pushReplacementNamed(context, '/foods');
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Food list'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Add Food', icon: Icon(Icons.create)),
              Tab(text: 'My Foods', icon: Icon(Icons.list)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CreateTab(_addFood),
            ListTab(_foods, _editFood),
          ],
        ),
      ),
    );
  }
}
