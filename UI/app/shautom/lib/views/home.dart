import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Media Device data config

    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: size.height,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: size.height * 0.01),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Text("Hello ${user.uid}"))
                    ]))),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF3F51B5),
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(Svg('assets/images/icons/home.svg')),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    Svg(
                      'assets/images/icons/person.svg',
                    ),
                    size: 30),
                label: 'Profile'),
            BottomNavigationBarItem(
                icon: ImageIcon(Svg('assets/images/icons/control.svg')),
                label: "Control"),
            BottomNavigationBarItem(
                icon: ImageIcon(Svg('assets/images/icons/monitor.svg')),
                label: 'Monitor'),
          ],
        ));
  }
}
