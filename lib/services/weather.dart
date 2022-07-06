import 'package:clima_whether/screens/loading_screen.dart';
import 'package:clima_whether/screens/location_screen.dart';
import 'package:clima_whether/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': '$cityName', 'appid': '$apikey' });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
    }
    var jsonResponse = jsonDecode(response.body);

    return jsonResponse;

  }
  /*

  Future<dynamic> getCityWeather(String cityName) async{
    Location location =  Location();
    await location.getCurrentLocation();




   Uri uri = Uri.https('api.openweathermap.org', '/data/2.5/weather?q=$cityName', {
      'lat': '${location.latitute}',
      'lon': '${location.longitude}',
      'ap pid': apikey,
    });
    http.Response response = await http.get(uri);

    var weatherData = jsonDecode(response.body);

    return weatherData;

  }

   */

  Future<dynamic> getLocationWeather() async{

    Location location =  Location();
    await location.getCurrentLocation();




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

    var content = jsonDecode(response.body);

    return content;


  }





  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
