import 'package:flutter/material.dart';

class Food {
  final String title;
  final String description;
  final double price;
  final String image;

  Food(
      {@required this.title,
      @required this.description,
      @required this.image,
      @required this.price});
}
