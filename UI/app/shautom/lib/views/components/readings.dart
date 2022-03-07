import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  final double temperature;

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
  final double? reading;
  final String? unit;

  ReadingWidget({this.reading, this.unit});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 45),
      decoration: BoxDecoration(
          color: Colors.white,
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
      child: CircleAvatar(
        backgroundColor: Colors.red.withAlpha(80),
        minRadius: size.width * 0.15,
        child: CircleAvatar(
          backgroundColor: Colors.blue.withAlpha(100),
          minRadius: size.width * 0.12,
          child: Center(
            child: Text(
              "$reading $unit",
              style: TextStyle(fontSize: size.height * 0.04),
            ),
          ),
        ),
      ),
    );
  }
}

class HumidityWidget extends StatelessWidget {
  final double humidity;

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
