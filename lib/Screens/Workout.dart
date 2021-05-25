import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Data/Dataset.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:intl/intl.dart';
import 'package:myproject/Theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myproject/Screens/feed.dart';
import 'package:myproject/Screens/records.dart';
import 'package:myproject/Screens/Stats.dart';
import 'package:myproject/Screens/home.dart';


class WorkoutSession extends StatefulWidget {
  final List sessionsToday;
  final database;
  WorkoutSession(this.database,this.sessionsToday);
  @override
  _WorkoutSessionState createState() => _WorkoutSessionState();
}

class _WorkoutSessionState extends State<WorkoutSession> {
  List<String> _screens = ['/feed', '/', '/stats', '/records'];
  StopWatchTimer _stopWatchTimer = StopWatchTimer();
  String dropDownValue;
  String sessionNow = 'None';
  var prevSession = [];
  var set = {};
  String displayTime;
  int selectedIndex;
  int _sets = 0;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<bool> selected = List<bool>.filled(6, false);
  @override
  void initState() {
    print(widget.sessionsToday);
    // TODO: implement initState
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Dataset>(
      builder: (context, dataset, child) {
        return SafeArea(
          child: Scaffold(
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
            ),
            backgroundColor: Color(0xff1E1E1E),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.black54,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                          initialData: 0,
                          builder: (context, snap) {
                            final value = snap.data;
                            displayTime = StopWatchTimer.getDisplayTime(value,
                                milliSecond: false);
                            return Container(
                              child: Text('$displayTime'),
                            );
                          },
                        ),
                        margin: EdgeInsets.only(top: 8.0),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        height: 40,
                        child: Center(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: widget.sessionsToday.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          '${widget.sessionsToday[index]}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: sessionNow ==
                                                    widget.sessionsToday[index]
                                                ? Colors.redAccent
                                                : Colors.white,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            selectedIndex = index;
                                            sessionNow =
                                                widget.sessionsToday[index];
                                            dropDownValue = null;
                                            print(sessionNow);
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: Center(
                          child: DropdownButton(
                            hint: Text('Pick an Excercise'),
                            value: dropDownValue,
                            items: dataset.excercise[sessionNow]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: value == dropDownValue
                                          ? Colors.redAccent
                                          : null),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  if(value != 'Pick a Session') {
                                    dropDownValue = value;
                                    set.putIfAbsent(sessionNow, () => {});
                                    set[sessionNow].putIfAbsent(
                                        dropDownValue,
                                            () =>
                                        {
                                          'sets': 0,
                                          'Reps': <int>[],
                                          'Weights': <double>[],
                                          'Type': <String>[]
                                        });
                                    _sets =
                                    set[sessionNow][dropDownValue]['sets'];
                                    prevSession = dataset.previousSessions(widget.database,
                                        sessionNow, dropDownValue);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: dropDownValue != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Sets - $_sets')],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text('Select an excercise'),
                                    )
                                  ],
                                ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
//                          height: 200,
                            decoration: BoxDecoration(
                                color: Color(0xff1E1E1E),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _sets,
                                itemBuilder:
                                    (BuildContext context, int indexAgain) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: dropDownValue != null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Set ${indexAgain + 1}'),
                                              Row(children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      set[sessionNow][
                                                                  dropDownValue]
                                                              ['Weights']
                                                          [indexAgain] -= 2.5;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                    '${set[sessionNow][dropDownValue]['Weights'][indexAgain]} Kgs'),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.greenAccent,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      set[sessionNow][
                                                                  dropDownValue]
                                                              ['Weights']
                                                          [indexAgain] += 2.5;
                                                    });
                                                  },
                                                ),
                                              ]),
                                              Row(children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.remove,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      set[sessionNow][
                                                                  dropDownValue]
                                                              ['Reps']
                                                          [indexAgain] -= 1;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                    '${set[sessionNow][dropDownValue]['Reps'][indexAgain]} R'),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.greenAccent,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      set[sessionNow][
                                                                  dropDownValue]
                                                              ['Reps']
                                                          [indexAgain] += 1;
                                                    });
                                                  },
                                                ),
                                              ]),
//                                            DropdownButton(
//                                              hint: Text('Set Type'),
//                                              value: set[sessionNow][date]
//                                                      [dropDownValue]['Type']
//                                                  [indexAgain],
//                                              items: dataset.type.map<
//                                                      DropdownMenuItem<String>>(
//                                                  (String value) {
//                                                return DropdownMenuItem<String>(
//                                                  value: value,
//                                                  child: Text(
//                                                    value,
//                                                    style: TextStyle(
//                                                        color: value ==
//                                                                set[sessionNow][
//                                                                            date]
//                                                                        [
//                                                                        dropDownValue]
//                                                                    [
//                                                                    'Type'][indexAgain]
//                                                            ? Colors.redAccent
//                                                            : null),
//                                                  ),
//                                                );
//                                              }).toList(),
//                                              onChanged: (value) {
//                                                setState(
//                                                  () {
//                                                    set[sessionNow][date]
//                                                                [dropDownValue]
//                                                            ['Type']
//                                                        [indexAgain] = value;
//                                                    print(indexAgain);
//                                                  },
//                                                );
//                                              },
//                                            ),
                                            ],
                                          )
                                        : null,
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            //todo: add a delete button
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (sessionNow != 'None' && dropDownValue != null)
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      _sets += 1;
                                      set[sessionNow][dropDownValue]['sets'] +=
                                          1;
                                      set[sessionNow][dropDownValue]['Type']
                                          .add('Classic');
                                      set[sessionNow][dropDownValue]['Weights']
                                          .add(25.0);
                                      set[sessionNow][dropDownValue]['Reps']
                                          .add(12);
                                    });
                                  },
                                ),
                              IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.cyanAccent,
                                ),
                                onPressed: () {
                                  List<double> weights =
                                      set[sessionNow][dropDownValue]['Weights'];
                                  List<int> reps =
                                      set[sessionNow][dropDownValue]['Reps'];
                                  int sets =
                                      set[sessionNow][dropDownValue]['sets'];
                                  List<String> type =
                                      set[sessionNow][dropDownValue]['Type'];
                                  print(weights);
                                  print(sets);
                                  print(reps);
                                  print(type);
                                  dataset.makeTodaysSession(
                                      sessionNow,
                                      dropDownValue,
                                      reps,
                                      weights,
                                      sets,
                                      date,
                                      type);
                                  print(dataset.todaysSession);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black54),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black54),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text(
                                'Previous Sessions',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.redAccent),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sets',
                                    style: kTextStyle1,
                                  ),
                                  Text(
                                    'Last Done',
                                    style: kTextStyle1,
                                  ),
                                  Text(
                                    'Reps',
                                    style: kTextStyle1,
                                  ),
                                  Text(
                                    'Weight',
                                    style: kTextStyle1,
                                  ),
                                ],
                              ),
                            ),
                            prevSession.isNotEmpty
                                ? Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: prevSession.isNotEmpty
                                            ? prevSession.length
                                            : 0,
                                        itemBuilder: (BuildContext context,
                                            int indexForLastSession) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12.0,
                                                left: 10.0,
                                                right: 8.0),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${prevSession[indexForLastSession][1]['sets']}',
                                                    style: kTextStyle,
                                                  ),
                                                  Text(
                                                    '${prevSession[indexForLastSession][0]} days ago',
                                                    style: kTextStyle,
                                                  ),
                                                  Text(
                                                    ' ${prevSession[indexForLastSession][1]['Reps'][0]}-${prevSession[indexForLastSession][1]['Reps'].last}',
                                                    style: kTextStyle,
                                                  ),
                                                  Text(
                                                    '${prevSession[indexForLastSession][1]['Weights'][0]}-${prevSession[indexForLastSession][1]['Weights'].last}',
                                                    style: kTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        'No workouts in records!',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 30,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    //Todo: Add an Alert !
                                    child: Text(
                                      'Reset',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        dataset.finished = false;
                                      });
                                      dataset.resetSession(date, context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Session',
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      List<String> bodyParts = dataset
                                          .todaysSession[date].keys
                                          .toList();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              backgroundColor: Color(0xff1E1E1E),
                                              elevation: 15,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          bodyParts.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index3) {
                                                        String part =
                                                            bodyParts[index3];
                                                        List listOfExc = dataset
                                                            .todaysSession[date]
                                                                [part]
                                                            .keys
                                                            .toList();
                                                        listOfExc.remove(
                                                            'total sets');
                                                        print(
                                                            'list of execs $listOfExc');
                                                        return (Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                  '$part',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .red)),
                                                            ),
                                                            ListView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    listOfExc
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index4) {
                                                                  String exc =
                                                                      listOfExc[
                                                                          index4];
                                                                  print(exc);
                                                                  return Padding(
                                                                    padding: const EdgeInsets.symmetric(vertical : 8.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                          width : 80,
                                                                          child: Text(
                                                                            '$exc',
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15,
                                                                                color:
                                                                                    Colors.white),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${dataset.todaysSession[date][part][exc]['sets']}',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  15,
                                                                              color:
                                                                                  Colors.white),
                                                                        ),
                                                                        Text(
                                                                          '${dataset.todaysSession[date][part][exc]['Reps'][0]} - ${dataset.todaysSession[date][part][exc]['Reps'].last}',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  15,
                                                                              color:
                                                                                  Colors.white),
                                                                        ),
                                                                        Text(
                                                                          '${dataset.todaysSession[date][part][exc]['Weights'][0]} - ${dataset.todaysSession[date][part][exc]['Weights'].last}',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  15,
                                                                              color:
                                                                                  Colors.white),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                })
                                                          ],
                                                        ));
                                                      }),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                  TextButton(
                                      child: Text(dataset.finished == false ?
                                        'Finish' : 'Home',
                                        style: TextStyle(
                                            color: Colors.greenAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          dataset.finished = true;
                                          Navigator.pop(context);
                                        });
                                        _stopWatchTimer.onExecute
                                            .add(StopWatchExecute.stop);
                                        int time;
                                        List<String> temp =
                                            displayTime.split(':');
                                        time = int.parse(temp[0] * 60) +
                                            int.parse(temp[2]);
                                        dataset.finishSession(widget.database,
                                            time.toString(), date);
                                      })
                                ],
                              ),
                            )
                          ])),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
