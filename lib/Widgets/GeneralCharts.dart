import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:myproject/Data/Dataset.dart';
class GeneralChart extends StatelessWidget {
  final double minY;
  final double maxY;
  final List<FlSpot> spots;
  final String freq;
  GeneralChart({this.minY, this.maxY, this.spots, this.freq});

  final Dataset dataset = Dataset();
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
        ),
        titlesData: FlTitlesData(
            leftTitles: SideTitles(
                reservedSize: 25,
                showTitles: true,
                interval: 5,
                getTextStyles: (value) => const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                getTitles: (value) {
                  return ((value).toString());
                }),
            bottomTitles: SideTitles(
                reservedSize: 22,
                margin: 5,
                interval: 2,
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
                getTitles: (value) {
                  return ((value).toInt().toString());
                }),
            show: true),
        minX: 1 ,
        maxX: freq == 'Monthly' ? 31 : 12,
        minY: minY,
        maxY: maxY,
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white30)),
        lineBarsData: [
          LineChartBarData(
              dotData: FlDotData(
                show: true,
              ),
              isCurved: true,
              spots: spots,
              barWidth: 1,
              colors: [
                ColorTween(begin: Colors.redAccent, end: Colors.red).lerp(0.2),
                ColorTween(begin: Colors.redAccent, end: Colors.red).lerp(0.2),
              ])
        ],
      ),
    );
  }
}
