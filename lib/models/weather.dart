import 'package:flutter/cupertino.dart';

class WeatherModel {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;
  bool isLoaded = false;

  WeatherModel(
      {this.coord,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.dt,
      this.sys,
      this.timezone,
      this.id,
      this.name,
      this.cod});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    isLoaded = true;
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      weather = new List<Weather>();
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    base = json['base'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    data['base'] = this.base;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    data['visibility'] = this.visibility;
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds.toJson();
    }
    data['dt'] = this.dt;
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    data['timezone'] = this.timezone;
    data['id'] = this.id;
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}

class Coord {
  double lon;
  double lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = (json['lon'] is int) ? json['lon'].toDouble() : json['lon'];
    lat = (json['lat'] is int) ? json['lat'].toDouble() : json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    return data;
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }

  IconData getIconData(){
    switch(this.icon){
      case '01d': return WeatherIcons.clear_day;
      case '01n': return WeatherIcons.clear_night;
      case '02d': return WeatherIcons.few_clouds_day;
      case '02n': return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d': return WeatherIcons.shower_rain_day;
      case '09n': return WeatherIcons.shower_rain_night;
      case '10d': return WeatherIcons.rain_day;
      case '10n': return WeatherIcons.rain_night;
      case '11d': return WeatherIcons.thunder_storm_day;
      case '11n': return WeatherIcons.thunder_storm_night;
      case '13d': return WeatherIcons.snow_day;
      case '13n': return WeatherIcons.snow_night;
      case '50d': return WeatherIcons.mist_day;
      case '50n': return WeatherIcons.mist_night;
      default: return WeatherIcons.clear_day;
    }
  }
}

class Main {
  int temp;
  int feelsLike;
  int tempMin;
  int tempMax;
  int pressure;
  int humidity;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = (json['temp'] is double) ? json['temp'].round() : json['temp'];
    feelsLike = (json['feels_like'] is double) ? json['feels_like'].round() : json['feels_like'];
    tempMin = (json['temp_min'] is double) ? json['temp_min'].round() : json['temp_min'];
    tempMax = (json['temp_max'] is double) ? json['temp_max'].round() : json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    return data;
  }
}

class Wind {
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = (json['speed'] is int) ? json['speed'].toDouble() : json['speed'];
    deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    return data;
  }
}

class Clouds {
  int all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys(
      {this.type,
      this.id,
      this.country,
      this.sunrise,
      this.sunset});

  Sys.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['country'] = this.country;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );
}
/// Exposes specific weather icons
/// Has all weather conditions specified by open weather maps API
/// https://openweathermap.org/weather-conditions
// hex values and ttf file from https://erikflowers.github.io/weather-icons/
class WeatherIcons {
  static const IconData clear_day = const _IconData(0xf00d);
  static const IconData clear_night = const _IconData(0xf02e);

  static const IconData few_clouds_day = const _IconData(0xf002);
  static const IconData few_clouds_night = const _IconData(0xf081);

  static const IconData clouds_day = const _IconData(0xf07d);
  static const IconData clouds_night = const _IconData(0xf080);

  static const IconData shower_rain_day = const _IconData(0xf009);
  static const IconData shower_rain_night = const _IconData(0xf029);

  static const IconData rain_day = const _IconData(0xf008);
  static const IconData rain_night = const _IconData(0xf028);

  static const IconData thunder_storm_day = const _IconData(0xf010);
  static const IconData thunder_storm_night = const _IconData(0xf03b);

  static const IconData snow_day = const _IconData(0xf00a);
  static const IconData snow_night = const _IconData(0xf02a);

  static const IconData mist_day = const _IconData(0xf003);
  static const IconData mist_night = const _IconData(0xf04a);
}