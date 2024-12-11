import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;  // location name for the UI
  late String time;   // time in that location
  String flag;  //url to an asset flag icon
  String url;   //location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  //Constructor
  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    int retryCount = 0;
    const maxRetries = 30;

    while (retryCount < maxRetries) {
      try{
        Response response = await get(Uri.parse("https://worldtimeapi.org/api/timezone/$url"));

        Map data = jsonDecode(response.body);
        //print(data);
        //get properties from data
        String datetime = data['datetime'];
        String offset = data['utc_offset'].substring(1,3);

        //Create DateTime object
        DateTime now = DateTime.parse(datetime);
        now.add(Duration(hours: int.parse(offset)));

        //set the time property
        isDaytime = now.hour > 6 && now.hour <20 ? true : false;
        this.time = DateFormat.jm().format(now);

        // exit while loop early
        if (response.statusCode == 200) {

          return;
        } else {
          print('Request failed with status code: ${response.statusCode}');
        }
      }
      catch(e){
        print('Caught error: $e');
      }
      retryCount++;
      print('Retrying... (Attempt $retryCount)');
      await Future.delayed(Duration(seconds: 2)); // Delay before retry
    }

  }
}

