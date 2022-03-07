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
        backgroundColor: Colors.blue.withOpacity(0.8),
        minRadius: size.width * 0.14,
        maxRadius: size.width * 0.15,
        child: CircleAvatar(
          backgroundColor: Colors.black.withOpacity(0.6),
          minRadius: size.width * 0.12,
          maxRadius: size.width * 0.13,
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
