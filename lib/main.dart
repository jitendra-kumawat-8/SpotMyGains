import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myproject/Screens/Workout.dart';
import 'package:myproject/Screens/home.dart';
import 'package:myproject/Screens/feed.dart';
import 'package:myproject/Screens/records.dart';
import 'package:myproject/Screens/Stats.dart';
import 'package:provider/provider.dart';
import 'package:myproject/Data/Dataset.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => Dataset(),
      child: MyApp()),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff1E1E1E),
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => MyHomePage(),
        '/feed' : (context) => Feed(),
        '/records' : (context) => Records(),
        '/stats' : (context) => Statistics(),
        '/workout' : (context) => WorkoutSession({},[]),
      },
    );
  }
}

