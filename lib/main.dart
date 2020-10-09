import 'package:firstfluttertest/pages/auth/login.dart';
import 'package:firstfluttertest/pages/foods/index.dart';
import 'package:firstfluttertest/scoped_models/foods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
//  MapView.setApiKey('AIzaSyAemtUjtkLbe7NDArfQuVcCtxHs_QIUDlY');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FoodModel _model = FoodModel();
  final _platformChannel = MethodChannel('osama.com/battery');

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await _platformChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level is $result %.';
    } catch (error) {
      batteryLevel = 'Failed to get bettery level!';
      print(error);
    }
    print(batteryLevel);
  }

  @override
  Widget build(BuildContext context) {
    _getBatteryLevel();
    return ScopedModel<FoodModel>(
      model: _model,
      child: MaterialApp(
        title: 'Foods',
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple),
        routes: {
          '/': (BuildContext context) {
            return FutureBuilder(
              future: _model.loadAuthentication(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (_model.isAuthenticated) {
                    return IndexPage();
                  } else {
                    return LoginPage();
                  }
                } else {
                  return Scaffold(
                    body: Center(
                      child: Theme.of(context).platform == TargetPlatform.iOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          },
          '/login': (BuildContext context) => LoginPage(),
          '/foods': (BuildContext context) => IndexPage(),
        },
      ),
    );
  }
}
