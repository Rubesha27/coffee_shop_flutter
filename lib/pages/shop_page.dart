import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/components/coffee_card.dart';
import 'package:coffee_shop/firebase%20services/firestore.dart';
import 'package:coffee_shop/models/coffee.dart';
import 'package:coffee_shop/models/coffee_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late final FirestoreService _firestoreService;

  @override
  void initState() {
    super.initState();
    _firestoreService =
        FirestoreService(FirebaseAuth.instance.currentUser!.uid);
  }

  void addCoffeeToCart(Coffee coffee) async {
    await _firestoreService.addItemToCart(coffee);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${coffee.name} added to cart')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // Heading message
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "How would you like your coffee?",
                style: GoogleFonts.lato(fontSize: 18),
              ),
            ),

            // Coffee list that adapts to orientation
            Expanded(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  bool isLandscape = orientation == Orientation.landscape;

                  return isLandscape
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemCount: value.coffeeShop.length,
                          itemBuilder: (context, index) {
                            Coffee eachCoffee = value.coffeeShop[index];
                            return CoffeeCard(
                              eachCoffee: eachCoffee,
                              onAdd: () => addCoffeeToCart(eachCoffee),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: value.coffeeShop.length,
                          itemBuilder: (context, index) {
                            Coffee eachCoffee = value.coffeeShop[index];
                            return CoffeeCard(
                              eachCoffee: eachCoffee,
                              onAdd: () => addCoffeeToCart(eachCoffee),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
