import 'package:intl/intl.dart';
class Functionality{
  final DateTime dateTime = DateTime.now();
  String getDateTime(){
    return(DateFormat('dd MM').format(dateTime));
  }
}