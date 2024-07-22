import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    try {
      // Check if the user has granted permission to access location
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return;
      }

      // Check if the user has granted permission to access the device's location
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          print('Location permission permanently denied');
          return;
        } else if (permission == LocationPermission.denied) {
          print('Location permission denied');
          return;
        }
      }

      // Get the device's location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );

      var weatherData = await WeatherModel().getLocationWeather(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      // Check if weatherData is not null before navigating
      if (weatherData != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LocationScreen(
                locationWeather: weatherData,
              );
            },
          ),
        );
      } else {
        // Handle the case where weather data is not available
        print('Failed to get weather data');
      }
    } catch (e) {
      print('Error in fetching weather data: $e');
    }
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
