import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            //shape: ShapeBorder.lerp(a, b, t),
            title: Text(
              'User Profile',
              style: TextStyle(),
            ),
            backgroundColor: Color(0xFF3F51B5),
          ),
          body: Container()),
    );
  }
}
