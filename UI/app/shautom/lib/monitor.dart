import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shautom/views/components/graph.dart';
import 'package:shautom/views/components/readings.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var formatter = NumberFormat.decimalPattern('en_us');
//var decimalFormatter = NumberFormat.0

class MonitorPage extends StatefulWidget {
  MonitorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int temperature = 26;
  bool tempOkay = true;
  bool humidityOkay = false;
  int humidity = 30;

  double energy = 0;

  late DatabaseReference _dhtRef;
  late Stream<DatabaseEvent> _dhtStream;

  late List<LiveEnergyData> _chartData;
  late TooltipBehavior _tooltipBehaviour;
  ChartSeriesController? _chartSeriesController;

  double time = 5;
  void updateDataSource(Timer timer) {
    _chartData.add(LiveEnergyData(
        timestamp: time++, value: ((math.Random().nextDouble()) * 400)));
    _chartData.removeAt(0);
    _chartSeriesController?.updateDataSource(
      addedDataIndex: _chartData.length - 1,
      removedDataIndex: 0,
    );
  }

  /// Initializes Firebase realtime database configuration & state
  Future<void> init() async {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    _dhtRef = FirebaseDatabase.instance
        .ref("Shautom/User/2vtcqvRNBVUPi0XtnxbUJRAy9GE2/sensor_readings/");

    _dhtStream = _dhtRef.onValue.asBroadcastStream();
    _dhtStream.listen(
      (DatabaseEvent evt) {
        final data = evt.snapshot.value as Map;
        Map dhtData = data['DHT22'];
        Map power = data['Power'];
        print("DHT : $dhtData \n Power : $power");

        setState(() {
          temperature = dhtData['temperature'].truncate();
          tempOkay = temperature <= 28;
          humidity = dhtData['humidity'].truncate();
          humidityOkay = humidity >= 30 && humidity <= 50;
          energy = power['energy'].toDouble();
        });
      },
    );
  }

  @override
  void initState() {
    _chartData = [
      LiveEnergyData(timestamp: 0, value: 23),
      LiveEnergyData(timestamp: 1, value: 78),
      LiveEnergyData(timestamp: 2, value: 23),
      LiveEnergyData(timestamp: 3, value: 89),
      LiveEnergyData(timestamp: 4, value: 320)
    ];

    _tooltipBehaviour = TooltipBehavior(enable: true);
    Timer.periodic(const Duration(seconds: 2), updateDataSource);
    super.initState();
    init();
  }

  @override
  void dispose() {
    _dhtStream.drain();
    //_dhtRef.onDisconnect();
    _chartData.clear();
    _chartSeriesController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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
            height: size.height * 0.4,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  border:
                      Border.all(color: Colors.blue.withOpacity(0.6), width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              // child: Center(
              //     child: Text(
              //   "No Data",
              //   style: TextStyle(color: Colors.white.withOpacity(0.8)),
              // )),
              child: Row(
                children: [
                  Flexible(
                      child: LivePowerGraph(
                    tooltipBehaviour: _tooltipBehaviour,
                    chartData: _chartData,
                    chartSeriesController: _chartSeriesController,
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
