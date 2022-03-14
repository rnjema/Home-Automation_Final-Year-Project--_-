import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlWidget extends StatefulWidget {
  final String applianceName;
  final String? appIconPath;
  final DatabaseReference? dbReference;
  ControlWidget(
      {Key? key,
      required this.applianceName,
      this.appIconPath,
      this.dbReference})
      : super(key: key);

  @override
  State<ControlWidget> createState() => _ControlWidgetState();
}

class _ControlWidgetState extends State<ControlWidget> {
  bool _isOn = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 45),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.blue,
              width: 4,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
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
                CupertinoSwitch(
                    value: _isOn,
                    onChanged: (value) async {
                      setState(() {
                        _isOn = value;
                      });
                      await widget.dbReference!.update({
                        "${widget.applianceName.replaceAll(' ', '').toLowerCase()}/state":
                            _isOn ? 1 : 0,
                      });
                    }),
              ],
            ),
          ],
        ));
  }
}
