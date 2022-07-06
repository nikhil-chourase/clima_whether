import 'package:geolocator/geolocator.dart';

class Location{
  double latitute=0;
  double longitude=0;

  Future<void> getCurrentLocation() async{
    try {

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitute = position.latitude;
      longitude = position.longitude;
    }
    catch(e) {
      print(e);
    }


  }




}

