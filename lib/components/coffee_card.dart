import 'package:flutter/material.dart';
import '../models/coffee.dart';

class CoffeeCard extends StatelessWidget {
  final Coffee eachCoffee;
  final VoidCallback onAdd;

  const CoffeeCard({super.key, required this.eachCoffee, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            eachCoffee.imagePath,
            width: 200,
            height: 200,
          ),
          ListTile(
            title: Text(eachCoffee.name),
            subtitle: Text('Rs ${eachCoffee.price}/-'),
            trailing: IconButton(
              color: Colors.brown,
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: onAdd,
            ),
          ),
        ],
      ),
    );
  }
}
