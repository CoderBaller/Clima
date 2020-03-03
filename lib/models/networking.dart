import 'dart:convert';
import 'package:clima/models/location.dart';
import 'package:clima/models/weather.dart';
import 'package:http/http.dart' as http;

const apiKey = '1a0b26932943795606acd0fb6ece0658';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class NetworkHelper {
  Future getData(String url) async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<WeatherModel> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();

    var weatherData = await getData(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    if (weatherData == null) {
      return new WeatherModel();
    } else {
      return new WeatherModel.fromJson(weatherData);
    }
  }

  Future<WeatherModel> getCityWeather(String cityName) async {
    var weatherData = await getData(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    if (weatherData == null) {
      return new WeatherModel();
    } else {
      return new WeatherModel.fromJson(weatherData);
    }
  }
}
