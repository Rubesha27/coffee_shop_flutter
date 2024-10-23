import 'package:flutter/material.dart';
import '../models/coffee.dart';

class CartProvider with ChangeNotifier {
  final List<Coffee> _cartItems = [];
  List<Coffee> get cartItems => _cartItems;

  double get totalBill => _cartItems.fold(
        0.0,
        (sum, coffee) => sum + double.parse(coffee.price),
      );

  void addCoffee(Coffee coffee) {
    _cartItems.add(coffee);
    notifyListeners();
  }

  void removeCoffee(String coffeeId) {
    _cartItems.removeWhere((coffee) => coffee.id == coffeeId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
