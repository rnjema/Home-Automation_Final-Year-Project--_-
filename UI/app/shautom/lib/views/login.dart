import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(),
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
      ),
    );
  }
}
