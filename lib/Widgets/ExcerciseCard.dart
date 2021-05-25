import 'package:flutter/material.dart';
import 'package:myproject/Data/Dataset.dart';
import 'package:provider/provider.dart';
class ExcerciseCards extends StatefulWidget {
  final String title;
  ExcerciseCards({this.title,});
  @override
  _ExcerciseCardsState createState() => _ExcerciseCardsState();
}

class _ExcerciseCardsState extends State<ExcerciseCards> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Dataset>(
        builder: (context, dataset, child){
      return SizedBox(
        width: 80,
        child: GestureDetector(
          onTap: () {
            setState(() {
              dataset.session[widget.title] = !dataset.session[widget.title];
            },);
          },
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: dataset.session[widget.title] ? Color(0xff1AFFD5) : Colors.white10,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(child: Text(widget.title, style: TextStyle(
                fontSize: 12, color: dataset.session[widget.title] ? Colors.black : Colors.white,
                fontWeight: dataset.session[widget.title] ? FontWeight.bold : FontWeight.normal
            ),)),
          ),
        ),
      );
    },);
  }
}