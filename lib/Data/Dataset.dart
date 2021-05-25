import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class Dataset extends ChangeNotifier {
  Map<String, bool> session = {
    'Legs': false,
    'Chest': false,
    'Biceps': false,
    'Triceps': false,
    'Abs': false,
    'Back': false,
    'Shoulder': false,
  };
  Map<String, List<String>> sessionDatesTracker = {
    "Back": [
      "2021-04-01",
      "2021-04-04",
      "2021-04-08",
      "2021-04-11",
      "2021-04-15",
      "2021-04-18",
      "2021-04-22",
      "2021-04-25",
      "2021-04-29",
      "2021-05-02",
      "2021-05-06",
      "2021-05-09",
      "2021-05-13",
      "2021-05-16"
    ],
    "Biceps": [
      "2021-04-01",
      "2021-04-04",
      "2021-04-08",
      "2021-04-11",
      "2021-04-15",
      "2021-04-18",
      "2021-04-22",
      "2021-04-25",
      "2021-04-29",
      "2021-05-02",
      "2021-05-06",
      "2021-05-09",
      "2021-05-13",
      "2021-05-16"
    ],
    "Chest": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Triceps": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Legs": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Shoulder": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ]
  };
  Map<String, String> timeKeeper = {
    "2021-04-07": '70',
    "2021-04-08": '72',
    "2021-04-09": '76',
    "2021-04-10": '80',
    "2021-04-11": '80',
    "2021-04-12": '75',
    "2021-04-13": '76',
    "2021-04-14": '78',
    "2021-04-15": '79',
    "2021-04-16": '80',
    "2021-04-17": '81',
    "2021-04-18": '82',
    "2021-04-19": '80',
  };
  List<String> listOfSessions = [ ];
  List<String> equipment = ['DumbBells', 'Rod', 'EZ-Rod', 'Bands', 'Machine'];
  List<String> type = ['Classic', 'Drop Set', 'Failure', 'Super Set'];
  List<String> variation = [
    'Incline',
    'Decline',
    'UnderHand',
    'OverHand',
    'Lateral',
    'Front'
  ];
  bool finished = false;
  Map<String, Map<String, dynamic>> todaysSession = {};
  Map<String, int> thisWeek = {
    'Legs': 0,
    'Chest': 0,
    'Abs': 0,
    'Back': 0,
    'Triceps': 0,
    'Biceps': 0,
    'Shoulder': 0
  };
  Map<String, int> thisMonth = {
    'Legs': 0,
    'Chest': 0,
    'Abs': 0,
    'Back': 0,
    'Triceps': 0,
    'Biceps': 0,
    'Shoulder': 0
  };
  Map<String, List<String>> excerciseDateTracker = {
    "Pulldown": [
      "2021-04-01",
      "2021-04-08",
      "2021-04-15",
      "2021-04-22",
      "2021-04-29",
      "2021-05-06",
      "2021-05-13"
    ],
    "DumbBell Row": [
      "2021-04-01",
      "2021-04-04",
      "2021-04-08",
      "2021-04-11",
      "2021-04-15",
      "2021-04-18",
      "2021-04-22",
      "2021-04-25",
      "2021-04-29",
      "2021-05-02",
      "2021-05-06",
      "2021-05-09",
      "2021-05-13",
      "2021-05-16"
    ],
    "Bent-Over Row": [
      "2021-04-01",
      "2021-04-08",
      "2021-04-15",
      "2021-04-22",
      "2021-04-29",
      "2021-05-06",
      "2021-05-13"
    ],
    "DeadLift": [
      "2021-04-01",
      "2021-04-04",
      "2021-04-08",
      "2021-04-11",
      "2021-04-15",
      "2021-04-18",
      "2021-04-22",
      "2021-04-25",
      "2021-04-29",
      "2021-05-02",
      "2021-05-06",
      "2021-05-09",
      "2021-05-13",
      "2021-05-16"
    ],
    "PullOver": [
      "2021-04-01",
      "2021-04-08",
      "2021-04-15",
      "2021-04-22",
      "2021-05-06"
    ],
    "Biceps Curl": [
      "2021-04-01",
      "2021-04-04",
      "2021-04-08",
      "2021-04-11",
      "2021-04-18",
      "2021-04-22",
      "2021-04-25",
      "2021-05-02",
      "2021-05-06",
      "2021-05-09",
      "2021-05-16"
    ],
    "EZ bar curl": [
      "2021-04-01",
      "2021-04-08",
      "2021-04-15",
      "2021-04-22",
      "2021-04-29",
      "2021-05-06",
      "2021-05-13"
    ],
    "DumbBell Curl": [
      "2021-04-01",
      "2021-04-08",
      "2021-04-22",
      "2021-05-06"
    ],
    "Preacher Curl": [
      "2021-04-01",
      "2021-04-08",
      "2021-04-15",
      "2021-04-22",
      "2021-04-29",
      "2021-05-06",
      "2021-05-13"
    ],
    "Decline Press": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Bench Press": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Incline Press": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Machine Fly": [
      "2021-04-02",
      "2021-04-09",
      "2021-04-23",
      "2021-05-07"
    ],
    "DumbBell CrossOver": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Overhead Extensions": [
      "2021-04-02",
      "2021-04-09",
      "2021-04-23",
      "2021-05-07"
    ],
    "Close Grip Bench Press": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Triceps Dips": [
      "2021-04-02",
      "2021-04-05",
      "2021-04-09",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-23",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-07",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "Cable PushDown": [
      "2021-04-02",
      "2021-04-09",
      "2021-04-16",
      "2021-04-23",
      "2021-04-30",
      "2021-05-07",
      "2021-05-14"
    ],
    "Squats": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Leg Press": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Goblet Squats": [
      "2021-04-03",
      "2021-04-10",
      "2021-04-17",
      "2021-04-24",
      "2021-05-01",
      "2021-05-08",
      "2021-05-15"
    ],
    "Front Squats": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Romanian DeadLift": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Axle Press": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Arnold Press": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Front Fly": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Lateral Fly": [
      "2021-04-03",
      "2021-04-06",
      "2021-04-10",
      "2021-04-13",
      "2021-04-17",
      "2021-04-20",
      "2021-04-24",
      "2021-04-27",
      "2021-05-01",
      "2021-05-04",
      "2021-05-08",
      "2021-05-11",
      "2021-05-15"
    ],
    "Landmine Row": [
      "2021-04-04",
      "2021-04-11",
      "2021-04-18",
      "2021-04-25",
      "2021-05-02",
      "2021-05-09",
      "2021-05-16"
    ],
    "UH Bent-Over Row": [
      "2021-04-04",
      "2021-04-11",
      "2021-04-18",
      "2021-04-25",
      "2021-05-02",
      "2021-05-09",
      "2021-05-16"
    ],
    "Lat PushDown": [
      "2021-04-04",
      "2021-04-11",
      "2021-04-18",
      "2021-04-25",
      "2021-05-02",
      "2021-05-09",
      "2021-05-16"
    ],
    "Concentration curl": [
      "2021-04-04",
      "2021-04-11",
      "2021-04-18",
      "2021-04-25",
      "2021-05-02",
      "2021-05-09",
      "2021-05-16"
    ],
    "Flex Curl": [
      "2021-04-04",
      "2021-04-11",
      "2021-04-18",
      "2021-04-25",
      "2021-04-29",
      "2021-05-02",
      "2021-05-09",
      "2021-05-13",
      "2021-05-16"
    ],
    "Hammer Curl": [
      "2021-04-04",
      "2021-04-11",
      "2021-04-15",
      "2021-04-18",
      "2021-04-25",
      "2021-04-29",
      "2021-05-02",
      "2021-05-09",
      "2021-05-13",
      "2021-05-16"
    ],
    "Cable Fly": [
      "2021-04-05",
      "2021-04-12",
      "2021-04-16",
      "2021-04-19",
      "2021-04-26",
      "2021-04-30",
      "2021-05-03",
      "2021-05-10",
      "2021-05-14",
      "2021-05-17"
    ],
    "OH Cable Extension ": [
      "2021-04-05",
      "2021-04-12",
      "2021-04-19",
      "2021-04-26",
      "2021-05-03",
      "2021-05-10",
      "2021-05-17"
    ],
    "Rope PushDown": [
      "2021-04-05",
      "2021-04-12",
      "2021-04-19",
      "2021-04-26",
      "2021-05-03",
      "2021-05-10",
      "2021-05-17"
    ],
    "Lunges": [
      "2021-04-06",
      "2021-04-13",
      "2021-04-20",
      "2021-04-27",
      "2021-05-04",
      "2021-05-11"
    ],
    "Face Pulls": [
      "2021-04-06",
      "2021-04-13",
      "2021-04-20",
      "2021-04-27",
      "2021-05-04",
      "2021-05-11"
    ],
    "Spider Curl": [
      "2021-04-15",
      "2021-04-29",
      "2021-05-13"
    ],
    "OH Rope Extension": [
      "2021-04-16",
      "2021-04-30",
      "2021-05-14"
    ],
    "Rope Row": [
      "2021-04-29",
      "2021-05-13"
    ],
    "R Cable PushDown": [
      "2021-04-30",
      "2021-05-14"
    ],
    "Reverse Curl": [
      "2021-05-02",
      "2021-05-16"
    ]
  };
  Map<String, List<String>> excercise ={
    "None": [
      "Pick a Session"
    ],
    "Legs": [
      "Front Squats",
      "Goblet Squats",
      "Squats",
      "Leg Press",
      "Lunges",
      "Leg Extensions",
      "Romanian DeadLift",
      "Dumbbell Stepup",
      "DeadLift",
      "Calf Raise",
      "Hip Thrust"
    ],
    "Chest": [
      "Bench Press",
      "Incline Press",
      "Decline Press",
      "Fly",
      "Cable Crossover",
      "Pullover",
      "Push-ups",
      "Machine Fly",
      "DumbBell CrossOver",
      "Cable Fly"
    ],
    "Biceps": [
      "Biceps Curl",
      "DumbBell Curl",
      "Preacher Curl",
      "Goblet Curl",
      "Reverse Curl",
      "Side Curl",
      "Chin ups",
      "EZ bar curl",
      "Concentration curl",
      "Flex Curl",
      "Hammer Curl",
      "Spider Curl"
    ],
    "Triceps": [
      "Close Grip Bench Press",
      "Triceps Extensions",
      "Triceps PushDown",
      "Underhand Kickbacks",
      "Triceps Dips",
      "Overhead Extensions",
      "Cable PushDown",
      "OH Cable Extension ",
      "Rope PushDown",
      "OH Rope Extension",
      "R Cable PushDown"
    ],
    "Abs": [
      "Plank",
      "Sit-Ups",
      "Leg Raise",
      "Flutter Kicks",
      "Crunches",
      "Russian Twist",
      "Superman",
      "Side Bend"
    ],
    "Back": [
      "Row",
      "Pull-Ups",
      "PullDown",
      "Chin Ups",
      "DeadLift",
      "Pulldown",
      "DumbBell Row",
      "Bent-Over Row",
      "PullOver",
      "Landmine Row",
      "UH Bent-Over Row",
      "Lat PushDown",
      "Rope Row"
    ],
    "Shoulder": [
      "Axel Press",
      "Arnold Press",
      "Face Pull",
      "Shoulder Raise",
      "OverHead Press",
      "Reverse FLy",
      "Upright Row",
      "Front Fly",
      "Lateral Fly",
      "Rear Delt Fly",
      "Axle Press",
      "Face Pulls"
    ]
  };
  int navBarIndex =1 ;
  List<double> months = [2.0, 5.0, 6.0, 7.0];
  List<double> weights = [52.0, 50.0, 51.0, 52.0];
  List<FlSpot> listOfWeights = [];


  void onTapIndex(int ind){
    navBarIndex = ind;
    notifyListeners();
  }
  List<FlSpot> flSpotsForWeight() {
    List<FlSpot> flSpots = [];
    for (int i = 0; i < months.length; i++) {
      flSpots.add(FlSpot(months[i], weights[i]));
    }
    return (flSpots);
  }

  void toggleSessions(String part) {
    if(listOfSessions.contains(part)){
      listOfSessions.remove(part);
    }
    else{
      listOfSessions.add(part);
    }
    notifyListeners();
  }

  void makeTodaysSession(String sessionNow, String dropdownValue, List reps,
      List<double> weights, int sets, String date, List type) {
    double maxWeight = weights.reduce((a, b) => max(a, b));
    double volume = 0;
    for (int i = 0; i < sets; i++) {
      volume += reps[i] * weights[i];
    }
    todaysSession.putIfAbsent(date, () => {});
    todaysSession[date].putIfAbsent(sessionNow, () => {});
    todaysSession[date][sessionNow].update('total sets',
        (dynamic val) => todaysSession[date][sessionNow]['total sets'] + sets,
        ifAbsent: () => sets);
    todaysSession[date][sessionNow].putIfAbsent(dropdownValue, () => {});
    todaysSession[date][sessionNow][dropdownValue]
        .update('sets', (dynamic val) => sets, ifAbsent: () => sets);
    todaysSession[date][sessionNow][dropdownValue].update(
        'max weight', (dynamic val) => maxWeight,
        ifAbsent: () => maxWeight);
    todaysSession[date][sessionNow][dropdownValue]
        .update('volume', (dynamic val) => volume, ifAbsent: () => volume);
    todaysSession[date][sessionNow][dropdownValue]
        .update('Reps', (dynamic val) => reps, ifAbsent: () => reps);
    todaysSession[date][sessionNow][dropdownValue]
        .update('Weights', (dynamic val) => weights, ifAbsent: () => weights);
    todaysSession[date][sessionNow][dropdownValue]
        .update('Type', (dynamic val) => type, ifAbsent: () => type);
    sessionDatesTracker[sessionNow].add(date);
    excerciseDateTracker[dropdownValue].add(date);
    notifyListeners();
  }

  void resetSession(String date, BuildContext context) {
    todaysSession = {};
    for (String key in sessionDatesTracker.keys) {
      if (sessionDatesTracker.containsKey(key)) {
        sessionDatesTracker[key].remove(date);
      }
    }
    Navigator.pop(context);
    notifyListeners();
  }

  void finishSession(var database, String time, String date) {
    database.addAll(todaysSession);
    for (String key in todaysSession[date].keys) {
      print(database[date][key]['total sets']);
    }
    timeKeeper[date] = time;
    notifyListeners();
  }

  List<List<dynamic>> previousSessions(var database,
      String sessionNow, String dropDownValue) {
    List<List<dynamic>> prev = [];
    for (String date in sessionDatesTracker[sessionNow].reversed) {
      if (date != DateTime.now().toString().split(' ')[0]) {
        print(database[date]);
        if (database[date][sessionNow].containsKey(dropDownValue)) {
          var temp = [];
          temp.add((DateTime.now().difference(DateTime.parse(date))).inDays);
          temp.add(database[date][sessionNow][dropDownValue]);
          if (prev.length == 2) {
            break;
          }
          prev.add(temp);
        }
      }
    }
    return (prev);
  }
  List<String> frequency = ['Frequency','Weekly', 'Monthly','Yearly'];
  Map weeksSession(var database, String start, String end) {
    DateTime dateTime = DateTime.parse(start);
    for (int i = 0; i < 6; i++) {
      String key = dateTime.add(Duration(days: i)).toString().split(' ')[0];
      if (database.containsKey(key)) {
        for (String body in database[key].keys) {
          thisWeek[body] += database[key][body]['total sets'];
        }
      }
    }
    print(thisWeek);
    return thisWeek;
  }
  Map monthSession(var database) {
    String mon = DateTime.now().month.toString();
    String day;
    if(mon.length == 1){
      mon= '0'+mon;
    }
    for (int i = 1; i < 31; i++) {
      if(i<=9){
        day = '0$i';
      }
      else{
        day = i.toString();
      }
      String key = '${DateTime.now().year}-$mon-$day';
      if (database.containsKey(key)) {
        for (String body in database[key].keys) {
          thisMonth[body] += database[key][body]['total sets'];
        }
      }
    }
    print(thisMonth);
    return thisMonth;
  }
  List<int> createRange(Map thisWeek) {
    List<int> rr = [];
    int maxNumber =
        thisWeek.values.toList().cast<int>().reduce((a, b) => max(a, b));
    int range = (maxNumber / 6).floor();
    for (int i = 0; i < maxNumber + range; i += range) {
      rr.add(i);
    }
    rr.remove(0);
    return (rr);
  }
List getChartData(var database, String sessionNow, String dropDownValue,
      String chartType, String freq) {
  List<FlSpot> flSpots = [];
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();
  String startDate;
  String endDate;
  Map avg = {};
  Map count = {};
  if(month.length == 1){
    month = '0'+month;
  }
  if(freq == 'Monthly'){
     startDate = '$year-$month-01';
    endDate = '$year-$month-31';
  }
  else if(freq == 'Yearly') {

    startDate = '$year-01-01';
    endDate = '$year-$month-31';
  }
    double minY = 100;
    double maxY = 0;
    print(month);
  if(freq == 'Monthly') {
    for (String ind in excerciseDateTracker[dropDownValue]) {
      if (DateTime.parse(ind).isAfter(DateTime.parse(startDate)) &&
          DateTime.parse(ind).isBefore(DateTime.parse(endDate))) {
        if (minY > database[ind][sessionNow][dropDownValue][chartType]) {
          minY =
              database[ind][sessionNow][dropDownValue][chartType].toDouble();
        }
        if (maxY < database[ind][sessionNow][dropDownValue][chartType]) {
          maxY =
              database[ind][sessionNow][dropDownValue][chartType].toDouble();
        }

        flSpots.add(FlSpot(DateTime
            .parse(ind)
            .day
            .toDouble(),
            database[ind][sessionNow][dropDownValue][chartType]
                .toDouble()));

    }
  }
}
  else if (freq == 'Yearly') {
    for (String ind in excerciseDateTracker[dropDownValue]) {
      String monthOfIndex = ind.split('-')[1];
      if (DateTime.parse(ind).isAfter(DateTime.parse(startDate)) &&
          DateTime.parse(ind).isBefore(DateTime.parse(endDate))) {
        if (minY > database[ind][sessionNow][dropDownValue][chartType]) {
          minY =
              database[ind][sessionNow][dropDownValue][chartType].toDouble();
        }
        if (maxY < database[ind][sessionNow][dropDownValue][chartType]) {
          maxY =
              database[ind][sessionNow][dropDownValue][chartType].toDouble();
        }
        double key = int.parse(monthOfIndex).toDouble();
        avg.update(key, (dynamic val) =>
        avg[key] + database[ind][sessionNow][dropDownValue][chartType]
            .toDouble(), ifAbsent: () =>
            database[ind][sessionNow][dropDownValue][chartType]
                .toDouble());
        count.update(key, (value) => count[key]+1, ifAbsent: () => 1);
      }
    }
    for (double key in avg.keys) {
      flSpots.add(FlSpot(key, avg[key]/count[key]));
    }
  }
  print(flSpots);
    return [flSpots, minY, maxY];

  }



  Map<String, int> getRadarData(var database, String freq){
    String startOfTheWeek;
    String endOfThisWeek;
    Map<String, int> returnData = {};
    startOfTheWeek = DateTime.now()
        .subtract(Duration(
        days: (7 - DateTime.now().weekday) == 0
            ? 6
            : (7 - DateTime.now().weekday)))
        .toString()
        .split(' ')[0];
    endOfThisWeek = DateTime.parse(startOfTheWeek)
        .add(Duration(days: 6))
        .toString()
        .split(' ')[0];
    if(freq == 'Weekly') {
      returnData = weeksSession(database, startOfTheWeek, endOfThisWeek);
    }
    else if(freq=='Monthly'){
      returnData = monthSession(database);
    }
    return returnData;
  }
}
