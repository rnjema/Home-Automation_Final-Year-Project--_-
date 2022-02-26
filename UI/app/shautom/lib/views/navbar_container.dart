import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class BottomNavBar extends StatefulWidget {
  //final Widget child;
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        //child: child,
      ),
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
