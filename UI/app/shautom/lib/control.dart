import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("Control Dashboard"),
        )
      ],
    ));
  }
}
