import 'dart:ffi';

class TodoItem {
  final String city="Bangkok";
  final String country= "Thailand";
  final String lastUpdated= "2023-10-26 09:00";
  final double tempC= 29.0;
  final double tempF= 84.2;
  final double feelsLikeC= 34.7;
  final double feelsLikeF=94.4;
  final double windKph= 13;
  final double windMph =8.1;
  final double humidity= 84;
  final int uv= 6;
  final condi = {
    "condition": {
      "text": "Partly cloudy",
      "icon": "https://cdn.weatherapi.com/weather/128x128/day/116.png",
      "code": 1003
    }
  };



  TodoItem({
    required String city,
    required String country,
    required double lastUpdated,
    required double tempC,
    required double tempF,
    required double feelsLikeC,
    required double feelsLikeF,
    required double windKph,
    required double windMph,
    required double humidity,
    required int uv,
    required condi,

  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      city: json['city'],
      country: json['country'],
      lastUpdated: json['lastUpdated'],
      tempC: json['tempC'].toDouble(),
      tempF:json['tempF'].toDouble(),

      feelsLikeC :json['feelsLikeC'].toDouble(),
        feelsLikeF:json['feelsLikeF'].toDouble(),
        windKph:json['windKph'].toDouble(),
        windMph:json['windMph'].toDouble(),
        humidity:json['humidity'].toDouble(),
      uv: json['uv'].toInt(),
      condi:json['condi'],


      // completed: json['completed'],
    );
  }
}