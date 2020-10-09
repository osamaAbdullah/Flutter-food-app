import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('use camera'),
                  onPressed: () => _getImage(context, ImageSource.camera),
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('chosse from gallary'),
                  onPressed: () => _getImage(context, ImageSource.gallery),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide:
              BorderSide(color: Theme.of(context).accentColor, width: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt, color: Theme.of(context).accentColor),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Add image',
                style: TextStyle(color: Theme.of(context).accentColor),
              )
            ],
          ),
          onPressed: () => _openImagePicker(context),
        ),
        SizedBox(
          height: 10.0,
        ),
        _imageFile == null
            ? Text('Pick an image')
            : Image.file(
                _imageFile,
                fit: BoxFit.cover,
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
              )
      ],
    );
  }
}
