// dessert_page.dart
import 'package:flutter/material.dart';

class DessertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dessert Page'),
      ),
      // Add your CRUD functionalities for dessert category here
      body: Center(
        child: const Text('Dessert CRUD'),
      ),
    );
  }
}
