import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //remove Item from cart
  void removeItemFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removeItem(coffee);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
        builder: (context, value, child) => SafeArea(
              child: Column(
                children: [
                  Text(
                    "Your Cart",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //List of coffees to buy
                  Expanded(
                      child: ListView.builder(
                          itemCount: value.userCart.length,
                          itemBuilder: (context, index) {
                            //get individual coffee
                            Coffee eachCoffee = value.userCart[index];
                            return ListTile(
                              title: Text(
                                eachCoffee.name,
                                style: TextStyle(fontSize: 16),
                              ),
                              subtitle: Text("Rs " + eachCoffee.price),
                              leading: Image.asset(
                                eachCoffee.imagePath,
                                alignment: Alignment.center,
                              ),
                              trailing: IconButton(
                                onPressed: () => removeItemFromCart(eachCoffee),
                                icon: Icon(Icons.delete),
                              ),
                            );
                          })),
                  // Total Bill Section
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Bill:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rs ${value.calculateTotalBill().toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
