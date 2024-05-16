import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => _favorites;
  void toggleFavorite(ProductModel product) {
    bool alreadyFavo = _favorites.any((item) => item.id == product.id);
    if (alreadyFavo) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isExist(ProductModel product) {
    final isExist = _favorites.contains(product);
    return isExist;
  }

  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
