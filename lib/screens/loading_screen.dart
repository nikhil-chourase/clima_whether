import 'package:clima_whether/services/weather.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_whether/screens/location_screen.dart';
import 'package:clima_whether/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



const apikey = '3099755f0e9fe82f30ad19a246b35531';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  void getLocationData() async{

    Location location =  Location();
    await location.getCurrentLocation();



    print(location.latitute);
    print(location.longitude);


    Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': '${location.latitute}',
      'lon': '${location.longitude}',
      'appid': apikey
    });
    http.Response response = await http.get(uri);

    if(response.statusCode==200) {
      String data = response.body;

    }else{
      print(response.statusCode);
    }




    /*
     the var content was must to fit this in location screen coz, locationWeather takes dynamic input
     and to convert it into dynamic, we wrap response.body into jsonDecode.
      and after refactoring we moved this to weather.dart

      */
    var content = jsonDecode(response.body);



    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return LocationScreen(
            locationWeather: content,
          );

        })
    );

  }






    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
