import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';

  Future<void> setupWorldTime() async {
    WorldTime wtinstance = WorldTime(location: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    await wtinstance.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': wtinstance.location,
      'flag': wtinstance.flag,
      'time': wtinstance.time,
      'isDaytime' : wtinstance.isDaytime,
    });

    /*print(wtinstance.time);
    setState(() {
      time = wtinstance.time;
    });*/

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
