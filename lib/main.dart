import 'package:flutter/material.dart';
import 'package:uts_neo/daftar_activity.dart';
// import 'package:uts_neo/login_activity.dart';
// import 'package:uts_neo/menu_activity.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "UTS NEO M Andhika Pratama",
      home: RegisterPage(),
    );
  }
}
