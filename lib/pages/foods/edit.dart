import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  final Function _editFood;
  final Map<String, dynamic> _food;
  final int _index;

  EditPage(this._food, this._editFood, this._index);

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
          title: Text('Update' + _food['title']),
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
                    RaisedButton(
                      child: Text('Update'),
                      textColor: Colors.white,
                      onPressed: () => _submit(context),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _titleField() {
    return TextFormField(
      initialValue: _food['title'],
      decoration: InputDecoration(labelText: 'Title'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        _food['title'] = value;
      },
    );
  }

  Widget _descriptionField() {
    return TextFormField(
      initialValue: _food['description'],
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
        _food['description'] = value;
      },
    );
  }

  Widget _priceField() {
    return TextFormField(
      initialValue: _food['price'].toString(),
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
        _food['price'] = value;
      },
    );
  }

  void _submit(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    print('sibmited');
    _formKey.currentState.save();
    _editFood(_food, _index);
    print('add executed');
    Navigator.pushReplacementNamed(context, '/foods');
  }
}
