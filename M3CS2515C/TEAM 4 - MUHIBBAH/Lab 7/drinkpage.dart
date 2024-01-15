// drink_page.dart
import 'package:flutter/material.dart';

class DrinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drink Page'),
      ),
      // Add your CRUD functionalities for drink category here
      body: Center(
        child: const Text('Drink CRUD'),
      ),
    );
  }
}
