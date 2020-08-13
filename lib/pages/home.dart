import 'package:flutter/material.dart';

import '../foods.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food list'),
      ),
      body: Foods(),
    );
  }

}