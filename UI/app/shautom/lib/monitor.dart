import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shautom/views/components/readings.dart';
import 'package:firebase_database/firebase_database.dart';

class MonitorPage extends StatefulWidget {
  MonitorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int temperature = 25;
  int humidity = 25;

  late DatabaseReference _dhtRef;
  late StreamSubscription<DatabaseEvent> _dhtSubscription;

  Future<void> init() async {
    _dhtRef = FirebaseDatabase.instance
        .ref("Shautom/User/2vtcqvRNBVUPi0XtnxbUJRAy9GE2/sensor_readings/DHT22");
    _dhtSubscription = _dhtRef.onValue.listen((DatabaseEvent evt) {
      final data = evt.snapshot.value;
      if (data != null) {
        setState(() {
          temperature = data['temperature'];
          humidity = data['humidity'];
        });
      }
    }, onError: () {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _dhtSubscription.cancel();
    _dhtSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: [
        Row(children: [
          Text("Temperature & Humidity"),
        ]),
        Divider(
          thickness: 2,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
            height: size.height * 0.6,
            child: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10, right: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20),
                physics: BouncingScrollPhysics(),
                children: [
                  GridTile(
                    child: TemperatureWidget(temperature: 25),
                    footer: Container(
                      padding: EdgeInsets.all(0),
                      child: GridTileBar(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "Temperature",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            maxRadius: size.width * 0.02),
                        subtitle: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Okay",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GridTile(
                      child: HumidityWidget(humidity: 25),
                      footer: Container(
                        padding: EdgeInsets.all(0),
                        child: GridTileBar(
                          title: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              "Humidity",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          leading: CircleAvatar(
                              backgroundColor: Colors.red,
                              maxRadius: size.width * 0.02),
                          subtitle: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Okay",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      )),
                ])),
      ],
    ));
  }
}
