import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class PowerGraph extends StatefulWidget {
  @override
  _PowerGraphState createState() {
    return _PowerGraphState();
  }
}

class _PowerGraphState extends State<PowerGraph> {
  late List<EnergyData> _chartData;
  late TooltipBehavior _tooltipBehaviour;

  @override
  void initState() {
    _chartData = getEnergyData();
    _tooltipBehaviour = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      //title: ChartTitle(text: "Energy Consumption Anlaysis"),
      legend: Legend(isVisible: false),
      tooltipBehavior: _tooltipBehaviour,
      series: <SplineAreaSeries>[
        SplineAreaSeries<EnergyData, double>(
            name: 'Energy Consumption',
            dataSource: _chartData,
            xValueMapper: (EnergyData energy, _) => energy.timestamp,
            yValueMapper: (EnergyData energy, _) => energy.value,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true,
            color: Colors.blue,
            opacity: 0.6,
            splineType: SplineType.cardinal,
            cardinalSplineTension: 0.7,
            xAxisName: "Time",
            yAxisName: "Energy Value")
      ],
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(
              text: "Timestamp",
              textStyle: TextStyle(fontSize: 10),
              alignment: ChartAlignment.center)),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelFormat: '{value}',
          title: AxisTitle(text: "Energy"),
          numberFormat: NumberFormat.decimalPattern("en-us")),
    );
  }

  List<EnergyData> getEnergyData() {
    final List<EnergyData> data = [
      EnergyData(timestamp: 0, value: 23),
      EnergyData(timestamp: 60, value: 78),
      EnergyData(timestamp: 123, value: 23),
      EnergyData(timestamp: 180, value: 89),
      EnergyData(timestamp: 240, value: 320)
    ];
    return data;
  }
}

class EnergyData {
  EnergyData({
    required this.timestamp,
    required this.value,
  });

  final double timestamp;
  final double value;
}

class LivePowerGraph extends StatelessWidget {
  final TooltipBehavior? tooltipBehaviour;
  ChartSeriesController? chartSeriesController;
  List<LiveEnergyData> chartData;

  LivePowerGraph({
    Key? key,
    this.tooltipBehaviour,
    this.chartSeriesController,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      //title: ChartTitle(text: "Energy Consumption Anlaysis"),
      legend: Legend(isVisible: false),
      tooltipBehavior: tooltipBehaviour,
      series: <SplineAreaSeries>[
        SplineAreaSeries<LiveEnergyData, double>(
            animationDuration: 2000,
            onRendererCreated: (ChartSeriesController controller) {
              chartSeriesController = controller;
            },
            name: 'Energy Consumption',
            dataSource: chartData,
            xValueMapper: (LiveEnergyData energy, _) => energy.timestamp,
            yValueMapper: (LiveEnergyData energy, _) => energy.value,
            dataLabelSettings: DataLabelSettings(isVisible: false),
            enableTooltip: true,
            color: Colors.blue,
            opacity: 0.6,
            splineType: SplineType.cardinal,
            cardinalSplineTension: 0.7,
            xAxisName: "Time",
            yAxisName: "Energy Value")
      ],
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          title: AxisTitle(
              text: "Timestamp",
              textStyle: TextStyle(fontSize: 10),
              alignment: ChartAlignment.center)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          title: AxisTitle(text: "Energy"),
          numberFormat: NumberFormat.decimalPattern("en-us")),
    );
  }

  double time = 5;
  void updateDataSource(Timer timer) {
    chartData.add(LiveEnergyData(
        timestamp: time++, value: ((math.Random().nextDouble()) * 400)));
    chartData.removeAt(0);
    chartSeriesController?.updateDataSource(
      addedDataIndex: chartData.length - 1,
      removedDataIndex: 0,
    );
  }
}

class LiveEnergyData {
  LiveEnergyData({
    required this.timestamp,
    required this.value,
  });

  final double timestamp;
  final double value;
}
