import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime = true;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      http.Response response = await http.get('http://worldtimeapi.org/api/timezone/$url');
      Map timeData = jsonDecode(response.body);

      String dateTime = timeData['datetime'];
      String offsetHours = timeData['utc_offset'].substring(1, 3);
      String offsetMins = timeData['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMins)));
      
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("error occured: $e");
      time = "Could not find time.";
    }
  }
}