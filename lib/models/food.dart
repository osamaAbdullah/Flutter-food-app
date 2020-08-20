import 'package:flutter/material.dart';

class Food {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final bool isFavorite;

  Food({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.price,
    this.isFavorite = false,
  });
}
