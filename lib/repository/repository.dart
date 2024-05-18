import 'package:dio/dio.dart';
import 'package:ecommerce_app/models/products.dart';
import 'package:flutter/foundation.dart';

class MyRepository {
  final Dio _dio = Dio();

  Future<List<ProductModel>?> fetchProductData() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        List<ProductModel> products = ProductModel.fromList(response.data);
        return products;
      } else {
        if (kDebugMode) {
          print(
              'Failed to fetch product data, status code: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching product data: $e');
      }
      return null;
    }
  }

  // Future<String> login(String username, String password) {
  //   try {

  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
