import 'package:clima/models/networking.dart';
import 'package:clima/widgets/weather_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/weather.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  NetworkHelper nh = new NetworkHelper();
  WeatherModel _weather;
  String _cityName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocationWeather();
  }

  Future<void> getLocationWeather() async {
    setState(() {
      _isLoading = true;
    });
    _weather = await nh.getLocationWeather();
    if(_weather.isLoaded){
      _cityName = _weather.name;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getCityWeather(String city) async {
    setState(() {
      _isLoading = true;
    });
    _weather = await nh.getCityWeather(city);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Text(
            DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[800],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCityChangeDialog,
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              constraints: BoxConstraints.expand(),
              color: Colors.grey[100],
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                    child: _weather.isLoaded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${_cityName.toUpperCase()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 5,
                                    fontSize: 42),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                _weather.weather[0].description.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 5,
                                    fontSize: 15),
                              ),
                              Icon(
                                _weather.weather[0].getIconData(),
                                size: 70,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '${_weather.main.temp}°',
                                style: TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  WeatherTile(
                                      "MIN", '${_weather.main.tempMin}°'),
                                  WeatherTile(
                                      "MAX", '${_weather.main.tempMax}°'),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  WeatherTile("WIND SPEED",
                                      '${(_weather.wind.speed * 3.6).round()}km/h'),
                                  WeatherTile(
                                    "HUMIDITY",
                                    '${_weather.main.humidity}%',
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  WeatherTile(
                                      "SUNRISE",
                                      DateFormat('hh:mm a').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              (_weather.sys.sunrise) * 1000))),
                                  WeatherTile(
                                      "SUNSET",
                                      DateFormat('hh:mm a').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              (_weather.sys.sunset) * 1000))),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.redAccent,
                                size: 24,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'There was an error fetching data',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 32),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FlatButton(
                                color: Colors.redAccent,
                                child: Text(
                                  "TRY AGAIN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 5,
                                    fontSize: 15),
                                ),
                                onPressed: (){
                                  if(_cityName != null){
                                    getCityWeather(_cityName);
                                  }else{
                                    getLocationWeather();
                                  }
                                }
                              )
                            ],
                          ),
                  ),
                ),
              ),
            ),
    );
  }

  void showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Change city', style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                onPressed: () {
                  getCityWeather(_cityName);
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: TextField(
              autofocus: true,
              onChanged: (text) {
                _cityName = text;
              },
              decoration: InputDecoration(
                hintText: 'Name of the city',
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
          );
        });
  }
}
