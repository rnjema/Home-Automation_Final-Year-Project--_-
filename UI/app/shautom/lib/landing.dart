import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'dart:async';
import 'dart:math' as math;

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:shautom/models/user.dart';
import 'package:shautom/views/components/graph.dart';
import 'package:shautom/views/components/readings.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class LandingPage extends StatefulWidget {
  UserModel? user;
  final bool loaded;
  DatabaseReference dataRef;

  LandingPage({
    Key? key,
    required this.user,
    required this.loaded,
    required this.dataRef,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late List<LiveEnergyData> _chartData;
  late TooltipBehavior _tooltipBehaviour;
  ChartSeriesController? _chartSeriesController;

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
  }

  @override
  void dispose() {
    _chartData.clear();
    _chartSeriesController = null;
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: GestureDetector(
                onTap: () => null,
                child: widget.loaded
                    ? RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            children: <InlineSpan>[
                            TextSpan(
                                text: "Welcome Home, \n",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "${widget.user!.firstName}",
                                style: TextStyle(
                                  color: Colors.blueGrey.withOpacity(0.7),
                                  //fontStyle: FontStyle.italic
                                ))
                          ]))
                    : Text(''),
              )),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            height: size.height * 0.25,
            child: ListView(
              children: [
                Card(
                  elevation: 2,
                  shadowColor: Colors.blue.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.1), width: 2)),
                  child: Container(
                    padding: EdgeInsets.only(left: 6, top: 3),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.thermostat,
                              color: Colors.red.withOpacity(0.4),
                            ),
                            FittedBox(
                              child: Text(
                                "Temperature",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.0015,
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5, top: 0),
                          height: size.height * 0.15,
                          child: Center(
                              child: StreamBuilder(
                            stream: widget.dataRef.onValue,
                            builder: (context, snap) {
                              if (snap.connectionState ==
                                  ConnectionState.waiting) {
                                return Container();
                              } else if (snap.hasData) {
                                DatabaseEvent evt = snap.data as DatabaseEvent;
                                dynamic data = evt.snapshot.value as Map;
                                int val =
                                    (data['DHT22']['temperature']).toInt();
                                return Center(
                                    child: TemperatureGauge(value: val));
                              } else if (snap.hasError) {
                                print("Error");
                              }

                              return Container();
                            },
                          )),
                        )
                      ],
                    ),
                    width: size.width * 0.6,
                    height: size.height * 0.3,
                  ),
                ),
                Card(
                  elevation: 2,
                  shadowColor: Colors.blue.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.1), width: 2)),
                  child: Container(
                    padding: EdgeInsets.only(left: 6, top: 3),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          Icon(
                            MaterialCommunityIcons.water_percent,
                            color: Colors.blue.withOpacity(0.4),
                          ),
                          SizedBox(width: 5),
                          FittedBox(
                              child: Text(
                            "Humidity",
                            style: TextStyle(fontSize: 16),
                          ))
                        ]),
                        Container(
                            padding: EdgeInsets.only(bottom: 5, top: 0),
                            height: size.height * 0.15,
                            child: StreamBuilder(
                              stream: widget.dataRef.onValue,
                              builder: (context, snap) {
                                if (snap.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else if (snap.hasData) {
                                  DatabaseEvent evt =
                                      snap.data as DatabaseEvent;
                                  dynamic data = evt.snapshot.value as Map;
                                  int val =
                                      data['DHT22']['humidity'].truncate();
                                  return Center(
                                      child: HumidityGauge(value: val));
                                } else if (snap.hasError) {
                                  print("Error");
                                }

                                return Container();
                              },
                            )),
                      ],
                    ),
                    width: size.width * 0.6,
                    height: size.height * 0.3,
                  ),
                ),
                Card(
                  elevation: 2,
                  shadowColor: Colors.blue.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.1), width: 2)),
                  child: Container(
                    padding: EdgeInsets.only(left: 6, top: 3),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisSize: MainAxisSize.max, children: [
                          Icon(
                            Icons.bolt,
                            color: Colors.red.withOpacity(0.4),
                          ),
                          FittedBox(
                            child: Text(
                              'Power',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ]),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Flexible(
                            child: LivePowerGraph(
                          tooltipBehaviour: _tooltipBehaviour,
                          chartData: _chartData,
                          chartSeriesController: _chartSeriesController,
                        )),
                      ],
                    ),
                    width: size.width * 0.6,
                    height: size.height * 0.3,
                  ),
                ),
              ],
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 15),
          Text('Devices', style: TextStyle(fontSize: 25)),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 0),
              height: size.height * 0.25,
              child: ListView(
                children: [
                  Card(
                    elevation: 2,
                    shadowColor: Colors.blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.1), width: 2)),
                    child: Container(
                      padding: EdgeInsets.only(left: 6, top: 3),
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(children: [
                            Icon(
                              MaterialCommunityIcons.lighthouse,
                              color: Colors.blue.withOpacity(0.4),
                            ),
                            SizedBox(width: 5),
                            FittedBox(
                                child: Text(
                              "Outdoor Lights",
                              style: TextStyle(fontSize: 14),
                            ))
                          ]),
                          Container(
                            padding: EdgeInsets.only(bottom: 5, top: 0),
                            height: size.height * 0.15,
                          ),
                        ],
                      ),
                      width: size.width * 0.5,
                      height: size.height * 0.23,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    shadowColor: Colors.blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.1), width: 2)),
                    child: Container(
                      padding: EdgeInsets.only(left: 6, top: 3),
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Icon(
                              MaterialCommunityIcons.security,
                              color: Colors.red.withOpacity(0.4),
                            ),
                            SizedBox(width: 5),
                            FittedBox(
                              child: Text(
                                'Security',
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                        ],
                      ),
                      width: size.width * 0.5,
                      height: size.height * 0.3,
                    ),
                  ),
                ],
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ]);
  }
}
