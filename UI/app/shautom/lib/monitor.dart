import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';

class MonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //shape: ShapeBorder.lerp(a, b, t),
          title: Text(
            'miHome : Monitoring Dashboard',
            style: TextStyle(),
          ),
          backgroundColor: Color(0xFF3F51B5),
        ),
        body: Column(
          children: <Widget>[LogoWidget()],
        ),
      ),
    );
  }
}
