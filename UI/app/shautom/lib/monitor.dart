import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class monitor extends StatefulWidget {
  const monitor({ Key? key }) : super(key: key);

  @override
  _monitorState createState() => _monitorState();
}

// ignore: camel_case_types
class _monitorState extends State<monitor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //shape: ShapeBorder.lerp(a, b, t),
          title: Text(
            'Monitoring Dashboard',
            style: TextStyle(),
          ),
          backgroundColor: Color(0xFF3F51B5),
        ),
        body: Container(),
      ),
    );
  }
}
