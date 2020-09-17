import 'package:firstfluttertest/pages/foods/edit.dart';
import 'package:firstfluttertest/scoped_models/foods.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FoodModel>(
      builder: (BuildContext context, Widget child, FoodModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
                key: Key(index.toString()),
                background: Container(color: Colors.red),
                onDismissed: (DismissDirection direction) {
                  print('dismissed direction is ${direction.toString()}');
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(model.foods[index].image),
                      ),
                      title: Text(model.foods[index].title),
                      subtitle: Text(model.foods[index].description),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return EditPage(model.foods[index], index);
                          }));
                        },
                      ),
                    ),
                    Divider(),
                  ],
                ));
          },
          itemCount: model.foods.length,
        );
      },
    );
  }
}
