import 'package:firstfluttertest/models/food.dart';
import 'package:firstfluttertest/pages/foods/detail.dart';
import 'package:firstfluttertest/pages/foods/manage.dart';
import 'package:firstfluttertest/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class IndexPage extends StatelessWidget {
  Widget _addButton(context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          model.addFood({
            'title': 'sara',
            'description': 'love you',
            'price': 12,
            'image': 'assets/food.jpg'
          });
        },
        child: Text('Add Product'),
      );
    });
  }

  Widget _buildTitlePriceRow(context, Food food) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            food.title,
            style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oswald'),
          ),
          SizedBox(
            width: 8.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(5.0)),
            child: Text(
              '\$${food.price.toString()}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, Food food, int index, Function deleteFood) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DetailPage(food)))
                .then((String action) {
              if (action == 'remove') {
                deleteFood(food.id);
              }
            });
          },
        ),
        ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(
                food.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              color: Colors.red,
              onPressed: () {
                model.toggleFavoriteStatus(index);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _renderList(List<Food> foods, Function deleteFood) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            children: <Widget>[
              Image.network(foods[index].image),
              _buildTitlePriceRow(context, foods[index]),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Text('Union Square, San Francisco'),
              ),
              _buildActionButtons(context, foods[index], index, deleteFood),
            ],
          ),
        );
      },
      itemCount: foods.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isNotFetched = true;
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
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return IconButton(
                icon: Icon(model.favoriteFilter
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  model.toggleFavoriteFilter();
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: _addButton(context),
          ),
          Expanded(child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              if (_isNotFetched) {
                model.fetchFoods();
                _isNotFetched = false;
              }
              Widget content = Center(
                child: Text('No foods found!'),
              );
              if (model.filteredFoods.length > 0 && !model.isLoading) {
                content = _renderList(model.filteredFoods, model.deleteFood);
              } else if (model.isLoading) {
                content = Center(
                  child: CircularProgressIndicator(),
                );
              }
              return content;
            },
          )),
        ],
      ),
    );
  }
}
