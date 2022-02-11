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
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.01, vertical: size.height * 0.01),
            child: LogoWidget(
              heightFactor: 0.3,
              widthFactor: 0.4,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    ));
  }
}
