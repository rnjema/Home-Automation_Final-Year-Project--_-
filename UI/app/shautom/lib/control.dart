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
      child: Scaffold(
          appBar: AppBar(
            //shape: ShapeBorder.lerp(a, b, t),
            title: Text(
<<<<<<< HEAD
              'Control',
              style: TextStyle(color: Colors.blue),
=======
              'Control Dashboard',
              style: TextStyle(),
>>>>>>> 1ff294cb9383136466a74e2f36564a5b85c16def
            ),
            backgroundColor: Colors.grey.withAlpha(50),
            elevation: 0, //Color(0xFF3F51B5)
          ),
          body: Container(
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
          )),
    );
  }
}
