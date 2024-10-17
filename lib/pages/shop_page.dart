import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/models/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  //Add item to cart
  void addCoffeeToCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).addItem(coffee);
    //show success message
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(coffee.name + " added to cart.")));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            //heading message
            Text(
              "How would you like your coffee today?",
              style: GoogleFonts.lato(fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            //List of coffees to buy
            Expanded(
                child: ListView.builder(
                    itemCount: value.coffeeShop.length,
                    itemBuilder: (context, index) {
                      //get individual coffee
                      Coffee eachCoffee = value.coffeeShop[index];
                      return Card(
                        margin: EdgeInsets.only(top: 50, left: 30, right: 30),
                        color: Colors.grey.shade100,
                        elevation: 14,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                eachCoffee.name,
                                style: GoogleFonts.sacramento(fontSize: 40),
                              ),
                              Image.asset(
                                eachCoffee.imagePath,
                                width: 250,
                                height: 230,
                                alignment: Alignment.center,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Rs " + eachCoffee.price + "/-",
                                      style: GoogleFonts.lato(fontSize: 20)),
                                  IconButton.filled(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.brown)),
                                      iconSize: 40,
                                      onPressed: () =>
                                          addCoffeeToCart(eachCoffee),
                                      icon: Icon(
                                        Icons.add,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
