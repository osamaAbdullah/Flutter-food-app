import 'package:firstfluttertest/scoped_models/foods.dart';
import 'package:firstfluttertest/scoped_models/users.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with FoodModel, UserModel {}
