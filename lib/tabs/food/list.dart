import 'package:firstfluttertest/pages/foods/edit.dart';
import 'package:flutter/material.dart';

class ListTab extends StatelessWidget {
  final List<Map<String, dynamic>> _foods;
  final Function _editFood;

  ListTab(this._foods, this._editFood);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          leading: Image.asset(_foods[index]['image']),
          title: Text(_foods[index]['title']),
          subtitle: Text(_foods[index]['description']),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return EditPage(_foods[index], _editFood, index);
              }));
            },
          ),
        );
      },
      itemCount: _foods.length,
    );
  }
}
