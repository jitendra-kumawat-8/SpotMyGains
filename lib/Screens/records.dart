import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myproject/Data/Dataset.dart';
import 'package:provider/provider.dart';
import 'package:myproject/Screens/feed.dart';
import 'package:myproject/Screens/home.dart';
import 'package:myproject/Screens/Stats.dart';
class Records extends StatefulWidget {
  final database;
  Records({this.database});
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  List<String> _screens = ['/feed','/','/stats','/records'];
  @override
  Widget build(BuildContext context) {
    return Consumer<Dataset>(
        builder: (context, dataset, child)
    {
      return Scaffold(
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
        body: Center(child: Text('Records'),),
      );
    }
    );
  }
}
