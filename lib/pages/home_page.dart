import 'package:coffee_shop/components/bottom_nav_bar.dart';
import 'package:coffee_shop/const.dart';
import 'package:coffee_shop/pages/cart_page.dart';
import 'package:coffee_shop/pages/shop_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//pages to display from bottom nav bar
  final List<Widget> _pages = [ShopPage(), CartPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
