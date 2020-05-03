import 'package:falconadmin/pages/menu_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Falcon Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}

