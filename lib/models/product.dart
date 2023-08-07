import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imgUrl,
    this.isFavorite = false,
  });

  // Method SetFavoriteValue
  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  // Method/Function status Favorite (Like)
  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final loveStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    final _url =
        'https://toko-apps-2-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=$token';

    try {
      // Put adl data yg sudah ada diganti dgn yg baru pd database (istilahnya ditumpuk/ditiban)
      final response = await http.put(
        _url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(loveStatus);
      }
    } catch (error) {
      _setFavValue(loveStatus);
    }
  }
}
