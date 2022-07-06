import 'package:flutter/material.dart';
import 'package:clima_whether/utilities/constants.dart';
import 'package:http/http.dart';
import 'package:clima_whether/services/weather.dart';
import 'package:clima_whether/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override

  LocationScreen({this.locationWeather});
  final locationWeather;

  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();

  var temprature;
  var description;
  var cityName;
  var weatherIcon;
  var condition;
  var weatherText;

  var tempShow;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(widget.locationWeather);
    print(widget.locationWeather);
  }

  void updateUI(dynamic weatherData){
    setState((){
      if(weatherData == null){
        temprature = 0;
        weatherIcon = null;
        weatherText = 'unable to get weather data';
        cityName = '';
        return;                                     //to end the method here itself

      }

      description = weatherData['weather'][0]['description'];
      cityName = weatherData['name'];


      double temp = weatherData['main']['temp']-273;
      temprature = temp.toInt();


      condition = weatherData['weather'][0]['id'];


      weatherIcon = weatherModel.getWeatherIcon(condition);

      weatherText = weatherModel.getMessage(temprature);


    });

    print(temprature);
    print(description);
    print(cityName);











  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return CityScreen();

                      }));
                      if(typedName!=null){
                        var weatherData = await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);

                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherText in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
