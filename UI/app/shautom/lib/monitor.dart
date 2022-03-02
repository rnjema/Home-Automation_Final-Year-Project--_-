import 'package:flutter/material.dart';
import 'package:shautom/views/components/temperature_widget.dart';

class MonitorPage extends StatelessWidget {
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
          Container(child: TemperatureWidget(temperature: 25)),
          Container(child: TemperatureWidget(temperature: 25)),
          Container(child: TemperatureWidget(temperature: 25)),
        ])));
  }
}
