import 'package:coffee_shop/models/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeShop extends ChangeNotifier {
  //coffee for sale list
  final List<Coffee> _shop = [
    Coffee(
        name: "Cappucino", price: "350", imagePath: "lib/images/cappucino.png"),
    Coffee(
        name: "Espresso", price: "250", imagePath: "lib/images/espresso.png"),
    Coffee(
        name: "Iced Coffee",
        price: "540",
        imagePath: "lib/images/iced_coffee.png"),
    Coffee(
        name: "Americano", price: "250", imagePath: "lib/images/americano.png"),
    Coffee(name: "Latte", price: "250", imagePath: "lib/images/latte.png"),
    Coffee(
        name: "Taro Milk Coffee",
        price: "450",
        imagePath: "lib/images/taro_milk_coffee.png"),
    Coffee(
        name: "Cinammon Rolls",
        price: "700",
        imagePath: "lib/images/cinammon_rolls.png"),
    Coffee(name: "Pancake", price: "600", imagePath: "lib/images/pancake.png"),
    Coffee(name: "Waffles", price: "450", imagePath: "lib/images/waffles.png"),
  ];

  //user cart
  List<Coffee> _userCart = [];
  //get coffee list
  List<Coffee> get coffeeShop => _shop;
  //get user cart
  List<Coffee> get userCart => _userCart;
  //add item to cart
  void addItem(Coffee coffee) {
    _userCart.add(coffee);
    notifyListeners();
  }

  //remove item to cart
  void removeItem(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }

  // Calculate total bill
  double calculateTotalBill() {
    double total = 0.0;
    for (var coffee in _userCart) {
      total += double.tryParse(coffee.price) ?? 0.0;
    }
    return total;
  }
}
