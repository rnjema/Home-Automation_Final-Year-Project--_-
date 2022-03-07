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
  bool tempOkay = true;
  bool humidityOkay = false;
  int humidity = 30;

  late DatabaseReference _dhtRef;
  late Stream<DatabaseEvent> _dhtStream;

  void getData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("readings");
    DatabaseEvent event = await ref.once();

    print(event.snapshot.value);
  }

  Future<void> init() async {
    _dhtRef = FirebaseDatabase.instance
        .ref("Shautom/User/2vtcqvRNBVUPi0XtnxbUJRAy9GE2/sensor_readings/DHT22");
    _dhtStream = _dhtRef.onValue;
    _dhtStream.listen(
      (DatabaseEvent evt) {
        final data = evt.snapshot.value as Map;
        print(data);

        setState(() {
          temperature = double.parse(data['temperature']).truncate();
          tempOkay = temperature <= 25;
          humidity = double.parse(data['humidity']).truncate();
          humidityOkay = humidity >= 30 && humidity <= 50;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _dhtStream.drain();
    //_dhtRef.onDisconnect();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: [
        Row(children: [
          Text(
            "Temperature & Humidity",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]),
        Divider(
          thickness: 2,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
            height: size.height * 0.25,
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
                    child: TemperatureWidget(temperature: temperature),
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
                            backgroundColor:
                                tempOkay ? Colors.green : Colors.red,
                            maxRadius: size.width * 0.02),
                        subtitle: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: tempOkay
                              ? Text(
                                  "Okay",
                                  style: TextStyle(color: Colors.black),
                                )
                              : Text("Critical",
                                  style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                  ),
                  GridTile(
                      child: HumidityWidget(humidity: humidity),
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
                              backgroundColor:
                                  !humidityOkay ? Colors.red : Colors.green,
                              maxRadius: size.width * 0.02),
                          subtitle: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: humidityOkay
                                ? Text(
                                    "Okay",
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text("Critical",
                                    style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      )),
                ])),
        Row(children: [
          Text(
            "Power Consumption",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]),
        Divider(
          thickness: 2,
          color: Colors.black,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [Text("General")],
        ),
        Divider(color: Colors.black),
        SizedBox(
          height: size.height * 0.25,
          child: Container(
            child: CircleAvatar(
              minRadius: size.width * 0.25,
              backgroundColor: Colors.blue.withOpacity(0.8),
              child: CircleAvatar(
                minRadius: size.width * 0.1,
                maxRadius: size.width * 0.2,
                backgroundColor: Colors.black.withOpacity(0.6),
                child: Text("3,520 KWh"),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
