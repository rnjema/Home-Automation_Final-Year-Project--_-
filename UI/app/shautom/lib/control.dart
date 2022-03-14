import 'package:flutter/material.dart';
import 'package:shautom/control_widget.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 10),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ControlWidget(applianceName: "Relay ${index + 1}");
          },
          itemCount: 4,
        ),
      ),
    );
  }
}
