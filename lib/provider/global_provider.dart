import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/products.dart';

// ignore: camel_case_types
class Global_provider extends ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> cartItems = [];
  List<ProductModel> favoriteItems = [];
  int currentIndex = 0;
  String? token = "";

  void setProduts(List<ProductModel> data) {
    products = data;
    notifyListeners();
  }

  void addCartItem(ProductModel data) {
    if (cartItems.any((e) => e.id == data.id)) {
      cartItems.removeWhere((e) => e.id == data.id);
    } else {
      cartItems.add(data);
    }
    notifyListeners();
  }

  void removeCartItem(ProductModel data) {
    cartItems.removeWhere((e) => e.id == data.id);
    notifyListeners();
  }

  void incrementCount(ProductModel item) {
    int index =
        cartItems.indexWhere((cartItem) => cartItem.title == item.title);

    if (index != -1) {
      cartItems[index].count++;
      //addProductCart(cartId!, user!.id!, item.id!, item.count);
      notifyListeners();
    }
  }

  void decrementCount(ProductModel item) {
    int index =
        cartItems.indexWhere((cartItem) => cartItem.title == item.title);

    if (index != -1) {
      cartItems[index].count--;
      //addProductCart(cartId!, user!.id!, item.id!, item.count);
      notifyListeners();
    }
  }

  void setFavorite(ProductModel item) {
    int index = products.indexWhere((product) => product.title == item.title);

    if (index != -1) {
      products[index].isFavorite = !products[index].isFavorite;
      int favIndex =
          favoriteItems.indexWhere((favItem) => favItem.title == item.title);

      if (favIndex == -1 && products[index].isFavorite) {
        favoriteItems.add(products[index]);
      } else if (favIndex != -1 && !products[index].isFavorite) {
        favoriteItems.removeAt(favIndex);
      }

      notifyListeners();
    }
  }

  void changeCurrentIdx(int idx) {
    currentIndex = idx;
    notifyListeners();
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}
