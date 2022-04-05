import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ControlWidget extends StatefulWidget {
  final String applianceName;
  final String? appIconPath;
  final DatabaseReference dbReference;
  ControlWidget(
      {Key? key,
      required this.applianceName,
      this.appIconPath,
      required this.dbReference})
      : super(key: key);

  @override
  State<ControlWidget> createState() => _ControlWidgetState();
}

class _ControlWidgetState extends State<ControlWidget> {
  bool _isOn = true;

  void initialize() {
    widget.dbReference.onValue.listen((event) {
      int relayNum = int.parse(widget.applianceName.split(' ')[1]);
      Map data = event.snapshot.value as Map;
      setState(() {
        _isOn = data['relay$relayNum']['state'] == 1;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      shadowColor: Colors.blue.withOpacity(0.5),
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.blue.withOpacity(0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 45),
          decoration: BoxDecoration(color: Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text("${widget.applianceName}"),
                Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
              ]),
              Row(
                children: [
                  FlutterSwitch(
                    value: _isOn,
                    showOnOff: true,
                    onToggle: (value) async {
                      setState(() {
                        _isOn = value;
                      });
                      await widget.dbReference.update({
                        "${widget.applianceName.replaceAll(' ', '').toLowerCase()}/state":
                            _isOn ? 1 : 0,
                      });
                    },
                    padding: 4,
                    height: size.height * 0.07,
                    activeIcon: Image(
                        image: AssetImage(
                      'assets/images/icons/power-plug-connected.png',
                    )),
                    inactiveIcon: Image(
                      image: AssetImage('assets/images/icons/power plug.png'),
                    ),
                    activeColor: Colors.grey.withOpacity(0.4),
                    inactiveColor: Colors.black.withOpacity(0.6),
                    toggleColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
