import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> countriesData = [
    WorldTime(location: 'Kolkata', flag: 'india.png', url: 'Asia/Kolkata'),
    WorldTime(location: 'London', flag: 'india.png', url: 'Europe/London'),
  ];

  void updateTime (index) async {
    WorldTime wt = countriesData[index];
    await wt.getTime();
    Navigator.pop(context, {
      'location': wt.location,
      'time': wt.time,
      'isDayTime': wt.isDayTime
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Choose a location"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: countriesData.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(countriesData[index].location),
            ),
          );
        }
      )
    );
  }
}
