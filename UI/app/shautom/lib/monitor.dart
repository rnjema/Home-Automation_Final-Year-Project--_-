import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class MonitorPage extends StatefulWidget {
  const MonitorPage({Key? key}) : super(key: key);

  @override
  _MonitorPageState createState() => _MonitorPageState();
}

// ignore: camel_case_types
class _MonitorPageState extends State<MonitorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //shape: ShapeBorder.lerp(a, b, t),
          title: Text(
            'Monitorng Dashboard',
            style: TextStyle(),
          ),
          backgroundColor: Color(0xFF3F51B5),
        ),
        body: Container(),
      ),
    );
  }
}
