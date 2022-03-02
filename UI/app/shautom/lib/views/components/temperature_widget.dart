import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  final int temperature;

  TemperatureWidget({
    Key? key,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CircleAvatar(
      backgroundColor: Colors.red.withAlpha(80),
      minRadius: size.width * 0.15,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        minRadius: size.width * 0.13,
        child: Center(
          child: Text(
            "25 \u2103",
            style: TextStyle(fontSize: size.height * 0.04),
          ),
        ),
      ),
    );
  }
}
