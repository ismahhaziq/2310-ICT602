// order_food_page.dart
import 'package:flutter/material.dart';
import 'foodpage.dart'; // Import the FoodPage
import 'drinkpage.dart'; // Import the DrinkPage
import 'dessertpage.dart'; // Import the DessertPage

class OrderFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Food Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to the FoodPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodPage()),
                );
              },
              child: const Text('Food'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the DrinkPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DrinkPage()),
                );
              },
              child: const Text('Drink'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the DessertPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DessertPage()),
                );
              },
              child: const Text('Dessert'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}

// Similar to the structure, you can create DrinkPage.dart and DessertPage.dart with CRUD functionalities.
