import 'package:flutter/material.dart';

class ActionCenter extends StatefulWidget {
  const ActionCenter({super.key});

  @override
  State<ActionCenter> createState() => _ActionCenterState();
}

class _ActionCenterState extends State<ActionCenter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 10.0,
            offset: const Offset(0, 2),
          ),
        ],
        color: const Color(0xFFFFFAFA),
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.favorite_rounded, color: Colors.black45),
            onPressed: () {
              // Handle favorite button press
            },
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: const Color(0xFFE0E0E0),
            ),
            child: const Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 40.0,
                right: 40.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.black45,
            ),
            onPressed: () {
              // Handle settings button press
            },
          ),
        ],
      ),
    );
  }
}
