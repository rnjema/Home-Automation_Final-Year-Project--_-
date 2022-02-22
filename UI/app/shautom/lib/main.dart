import 'package:flutter/material.dart';
import 'package:shautom/views/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue)),
    home: HomePage(),
  ));
}

/*
class MyApp extends StatelessWidget {
  final String title = "Smart Home";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Hide debug banner
      title: 'Smart Home',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}*/

