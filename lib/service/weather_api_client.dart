import 'dart:convert';
import 'dart:html';
import 'package:dreamup/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherApiclient{
  Future<Weather>? getcurrentWeather(String? location) async{
    var endpoint = Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$location&APPID=a3e49be4f8f578e46a5689a443d85584&units=metric");

    var respone = await http.get(endpoint);
    var body = jsonDecode(respone.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
    
  }
}