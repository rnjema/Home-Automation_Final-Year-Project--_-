import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/navbar_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScreenwithNavBar(
        child: Container(
      child: Column(
        children: <Widget>[
          Positioned(
            top: 5,
            child: LogoWidget(
              heightFactor: 0.3,
              widthFactor: 0.4,
            ),
          ),
        ],
      ),
    ));
  }
}
