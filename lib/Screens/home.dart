import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/Functionality/functionality.dart';
import 'package:myproject/Screens/Stats.dart';
import 'package:myproject/Screens/feed.dart';
import 'package:myproject/Screens/records.dart';
import 'package:myproject/Widgets/GeneralCharts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:myproject/Data/Dataset.dart';
import 'package:myproject/Widgets/Charts.dart';
import 'package:myproject/Widgets/ExcerciseCard.dart';
import 'package:myproject/Screens/Workout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var database;
  int weightToday = 50;
  Functionality func = Functionality();
  bool readyToRoll = false;
  List<String> _screens = ['/feed','/','/stats','/records'];
  Map session = {
    'Legs': false,
    'Chest': false,
    'Biceps': false,
    'Triceps': false,
    'Abs': false,
    'Back': false,
    'Shoulder': false,
  };
  Future<void> getDataset() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/database.json");
    database = json.decode(data);
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getDataset();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Dataset>(
        builder: (context, dataset, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Color(0xff1E1E1E),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: dataset.navBarIndex,
                backgroundColor: Color(0xff1E1E1E),
                iconSize: 20,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white38,
                showUnselectedLabels: true,
                onTap: (ind) {
                  dataset.navBarIndex = ind;
                  ind == 0 ?
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Feed(database: database,)),
                  ) : ind == 1 ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage())
                  ) : ind == 2 ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Statistics(database: database))) :  ind == 3 ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Records(database: database))) :   MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage());
                },

                items: [
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.userFriends),
                      label: 'Feed'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.list), label: 'Stats'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.trophy), label: 'Records')
                ],
              ),
              body: Container(
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        DateFormat('EEEE').format(DateTime.now()),
                        style: TextStyle(fontSize: 20,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold),),
                    ),
                    Center(
                      child: Text(
                        '${weightToday.toString()} Kg',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    NumberPicker(
                      minValue: 40,
                      maxValue: 100,
                      value: weightToday.toInt(),
                      onChanged: (value) {
                        setState(() {
                          weightToday = value;
                        });
                      },
                      axis: Axis.horizontal,
                      itemCount: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: GeneralChart(
                          maxY: 80,
                          minY: 40,
                          spots: dataset.flSpotsForWeight(),
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            TextButton(onPressed: () {
                              dataset.toggleSessions('Legs');
                              setState(() {
                                session['Legs'] = !session['Legs'];
                              });
                            }, child: Text('Legs', style: TextStyle(
                                color: session['Legs'] == true ? Colors
                                    .redAccent : null),)),
                            TextButton(onPressed: () {
                              dataset.toggleSessions('Chest');
                              setState(() {
                                session['Chest'] = !session['Chest'];
                              });
                            }, child: Text('Chest', style: TextStyle(
                                color: session['Chest'] == true ? Colors
                                    .redAccent : null))),
                            TextButton(onPressed: () {
                              dataset.toggleSessions('Biceps');
                              setState(() {
                                session['Biceps'] = !session['Biceps'];
                              });
                            }, child: Text('Biceps', style: TextStyle(
                                color: session['Biceps'] == true ? Colors
                                    .redAccent : null))),
                            TextButton(onPressed: () {
                              dataset.toggleSessions('Triceps');
                              setState(() {
                                session['Triceps'] = !session['Triceps'];
                              });
                            }, child: Text('Triceps', style: TextStyle(
                                color: session['Triceps'] == true ? Colors
                                    .redAccent : null))),
                            TextButton(onPressed: () {
                              dataset.toggleSessions('Shoulder');
                              setState(() {
                                session['Shoulder'] = !session['Shoulder'];
                              });
                            }, child: Text('Shoulder', style: TextStyle(
                                color: session['Shoulder'] == true ? Colors
                                    .redAccent : null))),
                            TextButton(onPressed: () {
                              dataset.toggleSessions('Back');
                              setState(() {
                                session['Back'] = !session['Back'];
                              });
                            }, child: Text('Back', style: TextStyle(
                                color: session['Back'] == true ? Colors
                                    .redAccent : null))),
                            TextButton(onPressed: () {
                              dataset.toggleSessions('Abs');
                              setState(() {
                                session['Abs'] = !session['Abs'];
                              });
                            }, child: Text('Abs', style: TextStyle(
                                color: session['Abs'] == true
                                    ? Colors.redAccent
                                    : null)))
                          ],
                        )
                    ),
                    GestureDetector(
                      onTap: () {
                        if(dataset.listOfSessions.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WorkoutSession(database, dataset.listOfSessions)),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent),
                        child: Center(
                          child: Text(dataset.finished == false ?
                            'Start' : 'Session',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

        }
    );
  }
}
