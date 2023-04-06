import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dreamup/models/weather.dart';
import 'package:flutter/material.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FutureBuilder(builder: (context, snapshot) {
        if (snapshot != null) {
          Weather _weather = snapshot.data;
          if (_weather == null) {
            return Text("Error getting weather");
          } else {
            return weatherBox(_weather);
          }
        } else {
          return CircularProgressIndicator();
        }
      },
      future: getCurrentWeather(),
      ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            "${_weather.temp}°C",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
          ),
        ),
        Text("${_weather.description}"),
        Text("Feel:${_weather.feelsLike}°C"),
        Text("H:${_weather.high}°C L:${_weather.low}°C"),
      ],
    );
  }

  Future getCurrentWeather() async {
    Weather weather;
    String city = "London";
    String apiKey = "a3e49be4f8f578e46a5689a443d85584";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";

    final response = await http.get(url as Uri);

    if (response.statusCode == 200) {
      weather = Weather.fromjson(jsonDecode(response.body));
    } else {}
  }
}
