import 'package:firstfluttertest/models/food.dart';
import 'package:firstfluttertest/scoped_models/foods.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EditPage extends StatelessWidget {
  final Food _food;
  final int _index;

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  EditPage(this._food, this._index);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double formWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double formPadding = deviceWidth - formWidth;
    return WillPopScope(
      onWillPop: () {
        print('back event');
        Navigator.pop(context, 'nothing'); // will go back
        return Future.value(
            false); // it must return a false if not it will pop the root page
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update' + _food.title),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: formPadding / 2),
                  children: <Widget>[
                    _titleField(),
                    _descriptionField(),
                    _priceField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant<FoodModel>(builder:
                        (BuildContext context, Widget child, FoodModel model) {
                      return RaisedButton(
                        child: Text('Update'),
                        textColor: Colors.white,
                        onPressed: () => _submit(context, model.editFood),
                      );
                    })
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _titleField() {
    return TextFormField(
      initialValue: _food.title,
      decoration: InputDecoration(labelText: 'Title'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      initialValue: _food.description,
      decoration: InputDecoration(labelText: 'Description'),
      maxLines: 4,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _priceField() {
    return TextFormField(
      initialValue: _food.price.toString(),
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a valid number.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  void _submit(context, Function editFood) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    editFood({
      'title': _formData['title'],
      'description': _formData['description'],
      'price': _formData['price'],
      'image': _formData['image']
    }, _food.id);
    print('add executed');
    Navigator.pushReplacementNamed(context, '/foods');
  }
}
