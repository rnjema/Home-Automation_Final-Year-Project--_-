import 'package:flutter/material.dart';
import 'package:shautom/views/components/readings.dart';
import 'package:firebase_database/firebase_database.dart';

class MonitorPage extends StatefulWidget {
  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  final datasbaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Container(
            child: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 40, right: 40),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20),
                physics: BouncingScrollPhysics(),
                children: [
          Container(child: TemperatureWidget(temperature: 25)),
          Container(child: HumidityWidget(humidity: 25)),
          Container(child: TemperatureWidget(temperature: 25)),
          Container(child: HumidityWidget(humidity: 25)),
        ])));
  }
}
