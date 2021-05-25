import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart' as chart;
import 'package:myproject/Data/Dataset.dart';
import 'package:myproject/Widgets/GeneralCharts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myproject/Screens/feed.dart';
import 'package:myproject/Screens/records.dart';
import 'package:myproject/Screens/Stats.dart';
import 'package:myproject/Screens/home.dart';

class Statistics extends StatefulWidget {
  final database;
  Statistics({this.database});

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  String value1;
  Map<String, int> thisWeek;
  String session = 'Legs';
  String excercise;
  String frequency1 = 'Frequency';
  String frequency2 = 'Frequency';
  bool chartShow = false;
  int chartType = 1;
  List chartData = [];
  Map<String, int> radarData = {};
  List<String> _screens = ['/feed','/','/stats','/records'];
  bool hasRadarData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Dataset>(builder: (context, dataset, child) {
      return SafeArea(
        child: Scaffold(
          bottomNavigationBar:  BottomNavigationBar(
            currentIndex: dataset.navBarIndex,
            backgroundColor: Color(0xff1E1E1E),
            iconSize: 20,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
            showUnselectedLabels: true,
            onTap: (ind){
              dataset.navBarIndex = ind;
              ind == 0 ?
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Feed(database: widget.database,)),
              ) : ind == 1 ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage())
              ) : ind == 2 ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Statistics(database: widget.database))) :  ind == 3 ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Records(database: widget.database))) :   MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage());
            },

            items: [
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.userFriends), label: 'Feed'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.list), label: 'Stats'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.trophy), label: 'Records')
            ],
          ) ,
          backgroundColor: Color(0xff1E1E1E),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0)),
            ),
            margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Choose Graph'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              chartType = 1;
                              chartShow = false;
                            });
                          },
                          child: Text(
                            'Focus',
                            style: TextStyle(
                                color: chartType == 1
                                    ? Colors.cyanAccent
                                    : null),
                          )),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              chartType = 2;
                              chartShow = false;
                              excercise = dataset.excercise[session][0];
                            });
                          },
                          child: Text('Growth',
                              style: TextStyle(
                                  color: chartType == 2
                                      ? Colors.cyanAccent
                                      : null))),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              chartType = 3;
                              chartShow = false;
                            });
                          },
                          child: Text('Body',
                              style: TextStyle(
                                  color: chartType == 3
                                      ? Colors.cyanAccent
                                      : null))),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      // color: Colors.black54,
                    ),
                    // margin: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          chartType == 2
                              ? Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DropdownButton(
                                      hint: Text('Part'),
                                      value: session,
                                      items: dataset.session.keys.toList()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: value == session &&
                                                        value != 'None'
                                                    ? Colors.redAccent
                                                    : null),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          session = value;
                                          excercise = dataset.excercise[session][0];
                                          chartShow = false;
                                          print(session);
                                        });
                                      },
                                    ),
                                    DropdownButton(
                                      hint: Text('Excercise'),
                                      value: excercise,
                                      items: dataset.excercise[session]
                                          .map<DropdownMenuItem<String>>(
                                              (String value1) {
                                        return DropdownMenuItem<String>(
                                          value: value1,
                                          child: Text(
                                            value1,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: value1 ==
                                                            excercise &&
                                                        value1 !=
                                                            'Pick a Session'
                                                    ? Colors.redAccent
                                                    : null),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value1) {
                                        setState(() {
                                          excercise = value1;
                                          chartShow = false;
                                        });
                                      },
                                    ),
                                    DropdownButton(
                                      value: frequency2,
                                      items: ['Frequency','Monthly','Yearly']
                                          .map<DropdownMenuItem<String>>(
                                              (String value2) {
                                        return DropdownMenuItem<String>(
                                          value: value2,
                                          child: Text(
                                            value2,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: value2 ==
                                                            frequency2 &&
                                                        value2 !=
                                                            'Frequency'
                                                    ? Colors.redAccent
                                                    : null),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value2) {
                                        setState(() {
                                          frequency2 = value2;
                                          chartShow = false;
                                        });
                                      },
                                    ),
                                  ],
                                )
                              : DropdownButton(
                                  value: frequency1,
                                  items: ['Frequency','Weekly','Monthly']
                                      .map<DropdownMenuItem<String>>(
                                          (String value2) {
                                    return DropdownMenuItem<String>(
                                      value: value2,
                                      child: Text(
                                        value2,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: value2 == frequency1 &&
                                                    value2 != 'Frequency'
                                                ? Colors.redAccent
                                                : null),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value2) {
                                    setState(() {
                                      frequency1 = value2;
                                      chartShow = false;
                                    });
                                  },
                                ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  if (chartType == 2) {
                                    chartData = dataset.getChartData(widget.database,
                                        session,
                                        excercise,
                                        'max weight',
                                        frequency2);
                                    if(frequency2!='Frequency') {
                                      chartShow = true;
                                    }
                                  } else if (chartType == 1) {
                                    radarData =
                                        dataset.getRadarData(widget.database, frequency1);
                                    for(String key in radarData.keys){
                                      if(radarData[key]!=0){
                                        hasRadarData = true;
                                        break;
                                      }
                                    }
                                    if(frequency1!='Frequency') {
                                      chartShow = true;
                                    }
                                  }
                                });
                              },
                              child: Text('Plot')),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: chartType == 1 && chartShow == true
                            ? Padding(
                              padding: const EdgeInsets.only(left : 30.0),
                              child: Container(
                                  child: hasRadarData == true ? chart.RadarChart(
                                    sides: 7,
                                    axisColor: Colors.white38,
                                    outlineColor: Colors.white38,
                                    data: [
                                      radarData.values.toList().cast<int>()
                                    ],
                                    features: radarData.keys
                                        .toList()
                                        .map((key) =>
                                            key +
                                            ' ${radarData[key].toString()}')
                                        .toList(),
                                    ticks: dataset.createRange(radarData),
                                    featuresTextStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                    ),
                                    ticksTextStyle: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    graphColors: [Colors.lightBlueAccent],
                                  ) : Center(child: Text('No Data to Plot!'),),
                                ),
                            )
                            : chartType == 2 && chartShow == true
                                ? GeneralChart(
                                    minY: chartData[1] - 10,
                                    maxY: chartData[2] + 10,
                                    spots: chartData[0],
                                    freq: frequency2,
                                  )
                                : chartType == 3 && chartShow == true
                                    ? Container()
                                    : Center(
                                        child: Text('Choose a Graph type'),
                                      )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
