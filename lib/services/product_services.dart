import 'package:dio/dio.dart';
import '../models/products.dart';

class ProductModelService {
  final Dio _dio = Dio();
  Future<List<ProductModel>> getProductModels() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products/1');

      if (response.statusCode == 200) {
        final List<dynamic> productModelData = response.data;
        return ProductModel.fromList(productModelData);
      } else {
        throw Exception('Failed to load ProductModels');
      }
    } catch (e) {
      throw Exception('Failed to load ProductModels: $e');
    }
  }
}
