import 'package:api_integration/screens/meme_home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MemeApp());
}


class MemeApp extends StatelessWidget {
  const MemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity),
        home: MemeHomePage(),
        );
  }
}
