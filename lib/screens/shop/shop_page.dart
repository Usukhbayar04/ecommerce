import 'dart:math';
import 'package:ecommerce_app/repository/repository.dart';
import 'package:flutter/material.dart';
import '../../models/products.dart';
import 'shopCard.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Future<List<ProductModel>> _getDataProduct() async {
    try {
      List<ProductModel>? data = await MyRepository().fetchProductData();
      if (data != null) {
        return data;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _getDataProduct(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 30),
              Text('API connecting data'),
            ],
          );
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                children: [
                  Flexible(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Wrap(
                            spacing: 20,
                            runSpacing: 10,
                            children: List.generate(
                              min(snapshot.data!.length, 6),
                              (index) => ShopCard(data: snapshot.data![index]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error fetching data'),
          );
        } else {
          return const Center(
            child: Text('No data available'),
          );
        }
      },
    );
  }
}
