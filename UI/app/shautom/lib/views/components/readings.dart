import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  final int temperature;

  TemperatureWidget({
    Key? key,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadingWidget(reading: temperature, unit: "\u2103");
  }
}

class ReadingWidget extends StatelessWidget {
  final int? reading;
  final String? unit;

  ReadingWidget({this.reading, this.unit});

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
            "$reading $unit",
            style: TextStyle(fontSize: size.height * 0.04),
          ),
        ),
      ),
    );
  }
}

class HumidityWidget extends StatelessWidget {
  final int humidity;

  HumidityWidget({
    Key? key,
    required this.humidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ReadingWidget(
      reading: humidity,
      unit: "%",
    );
  }
}
