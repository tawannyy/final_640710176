import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class Album {
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

  Album({
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


  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
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





class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dio = Dio(BaseOptions(responseType: ResponseType.json));
  List<Album>? _albumList;

  void fetchAlbums() async {
    try {
      final response = await _dio.get('https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=bangkok');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          _albumList = data.map((item) => Album.fromJson(item)).toList();
        });
      } else {
        print('Failed to fetch albums: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('weather in the world'), // Title in the AppBar
        ),
        body: _albumList == null
            ? Center(child: CircularProgressIndicator())
            :
        //ListView.builder(
        ListView.builder(
          itemCount: _albumList!.length,
          itemBuilder: (context, index) {
            var album = _albumList![index];
            return Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(album.city),
                        SizedBox(height: 4.0), // Add some spacing
                        Row(
                          children: [
                            Chip(
                              label: Text('Album ID: ${album.country}'),
                              backgroundColor: Colors.pink,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 4.0), // Add some spacing
                            Chip(
                              label: Text('User ID: ${album.uv}'),
                              backgroundColor: Colors.blue,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(), // Add a divider line between each album
              ],
            );
          },
        )




    );
  }
}