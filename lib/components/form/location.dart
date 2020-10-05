/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  final FocusNode _locationFocusNode = FocusNode();
  Uri _staticMapUri;

  @override
  void initState() {
    super.initState();
    getStaticMap();
    _locationFocusNode.addListener(_updateLocation);
  }

  @override
  void dispose() {
    // when widget is no longer on screen
    super.dispose();
    _locationFocusNode.removeListener(_updateLocation);
  }

  void _updateLocation() {}

  void getStaticMap() async {
    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyAemtUjtkLbe7NDArfQuVcCtxHs_QIUDlY');
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers(
        [Marker('id', 'title', 41.40338, 2.17403)],
        center: Location(41.40338, 2.17403),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      _staticMapUri = staticMapUri;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _locationFocusNode,
        ),
        SizedBox(
          height: 10.0,
        ),
        Image.network(_staticMapUri.toString()),
      ],
    );
  }
}
*/
