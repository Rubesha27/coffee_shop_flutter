import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/firebase%20services/firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/coffee.dart';

class CartPage extends StatelessWidget {
  final FirestoreService _firestoreService;

  CartPage({super.key})
      : _firestoreService =
            FirestoreService(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.brown,
      ),
      body: StreamBuilder<List<Coffee>>(
        stream: _firestoreService.getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          final cartItems = snapshot.data!;
          double totalBill = cartItems.fold(
              0,
              (sum, coffee) =>
                  sum + double.parse(coffee.price)); // Calculate total

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final coffee = cartItems[index];
                    return ListTile(
                      leading: Image.asset(coffee.imagePath, width: 50),
                      title: Text(coffee.name),
                      subtitle: Text('Rs ${coffee.price}/-'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await _firestoreService.deleteItemFromCart(coffee.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item removed')),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rs $totalBill/-',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        shape: CircleBorder(),
        foregroundColor: Colors.white,
        onPressed: () async {
          await _firestoreService.clearCart();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart cleared')),
          );
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
