import 'package:firstfluttertest/scoped_models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateTab extends StatelessWidget {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double formWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double formPadding = deviceWidth - formWidth;

    return GestureDetector(
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
                ScopedModelDescendant<MainModel>(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return RaisedButton(
                    child: Text('Add'),
                    textColor: Colors.white,
                    onPressed: () => _submit(context, model.addFood),
                  );
                }),
              ],
            ),
          )),
    );
  }

  Widget _titleField() {
    return TextFormField(
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

  void _submit(context, Function addFood) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    addFood({
      'title': _formData['title'],
      'description': _formData['description'],
      'price': _formData['price'],
      'image': _formData['image']
    });
    print('add executed');
    Navigator.pushReplacementNamed(context, '/foods');
  }
}
