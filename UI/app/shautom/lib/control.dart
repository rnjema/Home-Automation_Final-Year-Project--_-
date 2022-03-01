import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _isTvOn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        SwitchListTile(
          value: _isTvOn,
          onChanged: (bool value) {},
          title: Text("TV Appliance"),
          //subtitle: Switch,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(style: BorderStyle.solid),
          ),
          tileColor: Colors.blueAccent,
        ),
        ListTile(
          title: Text("Security Lights"),
        ),
        ListTile(
          title: Text("Room 1"),
        )
      ]),
    );
  }
}
