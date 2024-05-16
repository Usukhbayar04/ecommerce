import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';

class CartProvider extends ChangeNotifier {
  final List<ProductModel> _cart = [];
  List<ProductModel> get cart => _cart;
  void toggleFavorite(ProductModel product) {
    bool alreadyCart = _cart.any((item) => item.id == product.id);

    if (alreadyCart) {
      for (ProductModel element in _cart) {
        element.count++;
        break;
      }
    } else {
      _cart.add(product);
    }
    notifyListeners();
  }

  addIndex(int index) {
    if (_cart[index].count < 20) {
      _cart[index].count++;
    }
    notifyListeners();
  }

  subIndex(int index) {
    if (_cart[index].count > 1) {
      _cart[index].count--;
    }
    notifyListeners();
  }

  totalPrice() {
    double total = 0.0;
    for (ProductModel element in _cart) {
      total += element.price! * element.count;
    }
    return total;
  }

  static CartProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<CartProvider>(
      context,
      listen: listen,
    );
  }
}
