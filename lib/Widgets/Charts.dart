// import 'package:flutter/material.dart';
// import 'package:myproject/Data/Dataset.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:math';
// class ChartCard extends StatelessWidget {
//   const ChartCard({
//     Key key,
//     @required this.dataset,
//   });
//   final Dataset dataset;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 15, bottom: 10, left: 5, right: 20),
//       decoration: BoxDecoration(
//           color: Colors.black54),
//       child: LineChart(
//         LineChartData(
//           lineTouchData: LineTouchData(
//             enabled: false,
//           ),
//           titlesData: FlTitlesData(
//               leftTitles: SideTitles(
//                   reservedSize: 28,
//                   showTitles: true,
//                   interval: 5,
//                   getTextStyles: (value) => const TextStyle(
//                     color: Color(0xff1AFFD5),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                   ),
//                   getTitles: (value) {
//                     return ((value).toString());
//                   }),
//               bottomTitles: SideTitles(
//                   reservedSize: 22,
//                   margin: 5,
//                   showTitles: true,
//                   getTextStyles: (value) => const TextStyle(
//                       color: Color(0xff1AFFD5),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 10),
//                   getTitles: (value) {
//                     switch (value.toInt()) {
//                       case 0:
//                         return 'Jan';
//                       case 1:
//                         return 'Feb';
//                       case 2:
//                         return 'Mar';
//                       case 3:
//                         return 'Apr';
//                       case 4:
//                         return 'May';
//                       case 5:
//                         return 'Jun';
//                       case 6:
//                         return 'Jul';
//                       case 7:
//                         return 'Aug';
//                       case 8:
//                         return 'Sep';
//                       case 9:
//                         return 'Oct';
//                       case 10:
//                         return 'Nov';
//                       case 11:
//                         return 'Dec';
//                     }
//                     return '';
//                   }),
//               show: true),
//           minX: 0,
//           maxX: 11,
//           minY: dataset.weights.reduce(min) - 10,
//           maxY: dataset.weights.reduce(max) + 10,
//           gridData: FlGridData(
//             show: false,
//           ),
//           borderData: FlBorderData(
//               show: true,
//               border: Border.all(color: Colors.white30)),
//           lineBarsData: [
//             LineChartBarData(
//
//                 dotData: FlDotData(
//                   show: true,
//                 ),
//                 isCurved: true,
//                 spots: dataset.flSpots(),
//                 barWidth: 1,
//                 colors: [
//                   ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a)).lerp(0.2),
//                   ColorTween(begin: Color(0xff23b6e6), end: Color(0xff02d39a)).lerp(0.2),
//                 ])
//           ],
//         ),
//       ),
//     );
//   }
// }
