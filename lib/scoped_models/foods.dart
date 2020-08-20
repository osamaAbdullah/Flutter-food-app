import 'dart:convert';

import 'package:firstfluttertest/models/food.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

mixin FoodModel on Model {
  List<Food> _foods = [];
  bool _favoriteFilter = false;
  bool _isLoading = false;

  //getters
  bool get favoriteFilter {
    return _favoriteFilter;
  }

  List<Food> get foods {
    return List.from(_foods);
  }

  bool get isLoading {
    return _isLoading;
  }

  List<Food> get filteredFoods {
    if (_favoriteFilter) {
      return _foods.where((food) => food.isFavorite).toList();
    }
    return List.from(_foods);
  }

  //crud
  Future<Null> fetchFoods() {
    this._isLoading = true;
    return http
        .get('https://flutter-test-8ae0a.firebaseio.com/foods.json')
        .then((http.Response response) {
      this._foods.clear();
      final Map<String, dynamic> foods = json.decode(response.body);
      if (foods != null) {
        foods.forEach((String foodId, dynamic food) {
          food.putIfAbsent('id', () => foodId);
          this._foods.add(mapToFood(food));
        });
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> addFood(Map<String, dynamic> food) {
    this._isLoading = true;
    return http
        .post('https://flutter-test-8ae0a.firebaseio.com/foods.json',
            body: json.encode({
              "title": food['title'],
              "description": food['description'],
              "price": food['price'],
              "image":
                  "https://cdn11.bigcommerce.com/s-ham8sjk/images/stencil/1280x1280/products/279/841/sugar_free_chocolate_chips__1551730133_104.172.159.225__93384.1551730169.jpg?c=2"
            }))
        .then((http.Response response) {
      if (response.statusCode != 200 && response.statusCode != 201) {
        return false;
      }
      food.putIfAbsent('id', () => json.decode(response.body)['name']);
      _foods.add(mapToFood(food));
      this._isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      return false;
    });
  }

  Future<bool> editFood(Map<String, dynamic> food, String foodId) async {
    food.update(
        'image',
        (_) =>
            "https://cdn11.bigcommerce.com/s-ham8sjk/images/stencil/1280x1280/products/279/841/sugar_free_chocolate_chips__1551730133_104.172.159.225__93384.1551730169.jpg?c=2");
    try {
      final http.Response response = await http.put(
          'https://flutter-test-8ae0a.firebaseio.com/foods/${foodId}.json',
          body: json.encode(food));

      return true;
    } catch (error) {
      return false;
    }
  }

  void deleteFood(String foodId) {
    _foods.removeWhere((food) => food.id == foodId);
    http
        .delete(
            'https://flutter-test-8ae0a.firebaseio.com/foods/${foodId}.json')
        .then(
            (res) {}); // after that it will automatically fetch last data from firebase
  }

  // helpers
  Food mapToFood(Map<String, dynamic> food) {
    return Food(
        id: food['id'],
        title: food['title'],
        description: food['description'],
        price: food['price'].toDouble(),
        image:
            "https://cdn11.bigcommerce.com/s-ham8sjk/images/stencil/1280x1280/products/279/841/sugar_free_chocolate_chips__1551730133_104.172.159.225__93384.1551730169.jpg?c=2");
  }

  void toggleFavoriteStatus(int index) {
    Food food = Food(
        id: foods[index].id,
        title: foods[index].title,
        description: foods[index].description,
        image: foods[index].image,
        price: foods[index].price,
        isFavorite: !foods[index].isFavorite);
    _foods[index] = food;
    notifyListeners();
  }

  void toggleFavoriteFilter() {
    _favoriteFilter = !_favoriteFilter;
    notifyListeners();
  }
}
