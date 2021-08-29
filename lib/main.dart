import 'package:flutter/material.dart';
import 'package:image_search/screens/photo_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhotoScreen(),
    );
  }
}
