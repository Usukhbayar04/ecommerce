// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/favorite_provider.dart';
import '../../models/products.dart';
import '../../provider/auth_provider.dart';
import '../detail/detail_page.dart';
import '../login_signup/login.dart';

class ProductCard extends StatelessWidget {
  final ProductModel data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String shortenText(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      } else {
        return '${text.substring(0, maxLength)}...';
      }
    }

    final providerFavo = FavoriteProvider.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(data: data)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Container(
          width: 180,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 130,
                      width: 800,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data.image!),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    if (data.rating != null) ...[
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            if (i < data.rating!.rate!.floor())
                              const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 255, 230, 0),
                                size: 18,
                              )
                            else if (i < data.rating!.rate!)
                              const Icon(
                                Icons.star_half,
                                color: Color.fromARGB(255, 255, 230, 0),
                                size: 18,
                              )
                            else
                              const Icon(
                                Icons.star_border,
                                color: Color.fromARGB(255, 255, 230, 0),
                                size: 18,
                              ),
                          const SizedBox(width: 5),
                          Text(
                            '${data.rating!.rate} (5)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                Text(
                  shortenText(data.title!, 10),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.price!.toString(),
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          if (authProvider.isLoggedIn) {
                            providerFavo.toggleFavorite(data);
                            if (kDebugMode) {
                              print('nevtersen bn');
                            }
                          } else {
                            if (kDebugMode) {
                              print('not logged in.');
                            }
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }
                        },
                        child: Icon(
                          providerFavo.isExist(data)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
