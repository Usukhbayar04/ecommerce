import 'package:ecommerce_app/Provider/card_provider.dart';
import 'package:ecommerce_app/Provider/favorite_provider.dart';
import 'package:ecommerce_app/global_keys.dart';
import 'package:ecommerce_app/provider/auth_provider.dart';
import 'package:ecommerce_app/provider/global_provider.dart';
import 'package:ecommerce_app/screens/login_signup/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/bag/bag_page.dart';
import 'screens/home/home_page.dart';
import 'screens/profile/profile_page.dart';
import 'screens/shop/shop_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => Global_provider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: GlobalKeys.navigatorKey,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 231, 227, 227),
            ),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color.fromARGB(255, 233, 227, 227),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
            '/shop': (context) => const ShopPage(),
            '/bag': (context) => const BagPage(),
            '/profile': (context) => const ProfilePage(),
          },
        ),
      );
}
