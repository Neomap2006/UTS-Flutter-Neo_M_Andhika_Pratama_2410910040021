import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Image.asset(
            "Gambar/Logo.png",
            width: 50,
            height: 100,
          ),
        ],
      ),
    );
  }
}