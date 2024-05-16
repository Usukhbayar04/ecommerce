import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Provider/card_provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  Future<bool> login(
      BuildContext context, String email, String password) async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      for (var user in data) {
        if (user['email'] == email && user['password'] == password) {
          if (kDebugMode) {
            print('User authenticated');
          }
          return true;
        }
      }
      if (kDebugMode) {
        print('Invalid email or password');
      }
      return false;
    } else {
      if (kDebugMode) {
        print('Failed to authenticate. Server error.');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                '\$${provider.totalPrice()}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${provider.totalPrice()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              bool isLoggedIn =
                  await login(context, 'user@example.com', 'password');
              if (isLoggedIn) {
                if (kDebugMode) {
                  print('price: ${provider.totalPrice()}');
                }
              } else {
                if (kDebugMode) {
                  print('user not loggin in');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              minimumSize: const Size(double.infinity, 55),
            ),
            child: const Text(
              'Check out',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
