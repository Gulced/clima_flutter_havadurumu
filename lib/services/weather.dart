import 'package:clima_flutter/services/networking.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:http/http.dart' as http;
const apiKey = 'e72ca729af228beabd5d20e3b7749713';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';


class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = Uri.parse('$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print('Failed to load data: ${response.statusCode}');
      throw 'Failed to load weather data';
    }
  }

  Future<dynamic> getLocationWeather({required double latitude, required double longitude}) async {
    var url = Uri.parse('$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print('Failed to load data: ${response.statusCode}');
      throw 'Failed to load weather data';
    }
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
