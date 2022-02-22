import 'package:flutter/material.dart';
import 'package:shautom/views/home.dart';

//Firebase initialization imports
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options : DefaultFirebaseOptions.currentPlatform,
      );
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

