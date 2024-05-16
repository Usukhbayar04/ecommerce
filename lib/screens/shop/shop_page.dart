import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/products.dart';
import 'shopCard.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Future<List<ProductModel>> _getData() async {
    String result = await DefaultAssetBundle.of(context)
        .loadString("assets/data/products.json");
    return ProductModel.fromList(jsonDecode(result));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(15),
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
        } else if (ConnectionState.waiting == snapshot.connectionState) {
          return const Center(
            child: CircularProgressIndicator(),
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
