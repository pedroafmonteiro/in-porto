import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Text(
          'Favorites Page',
          style: TextStyle(fontSize: 24, color: Colors.black54),
        ),
      ),
    );
  }
}