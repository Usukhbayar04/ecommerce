import 'package:flutter/material.dart';
import 'screens/home/home_page.dart';
import 'screens/shop/shop_page.dart';
import 'screens/bag/bag_page.dart';
import 'screens/profile/profile_page.dart';
import 'screens/favorite/favorite_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const ShopPage(),
    const BagPage(),
    const FavoritePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                size: 26,
                color: currentIndex == 0 ? Colors.black : Colors.black45,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 26,
                color: currentIndex == 1 ? Colors.black : Colors.black45,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: Icon(
                Icons.badge_rounded,
                size: 26,
                color: currentIndex == 2 ? Colors.black : Colors.black45,
              ),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: 26,
                color: currentIndex == 3 ? Colors.black : Colors.black45,
              ),
              onPressed: () => _onItemTapped(3),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 26,
                color: currentIndex == 4 ? Colors.black : Colors.black45,
              ),
              onPressed: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}
