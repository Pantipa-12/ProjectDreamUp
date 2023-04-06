import 'dart:html';

import 'package:dreamup/views/current_weather.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dreamup/views/additional_information.dart';
import 'package:dreamup/service/weather_api_client.dart';
import 'package:dreamup/model/weather_model.dart';
import 'package:dreamup/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget build(BuildContext context) {
  return MaterialApp(
    home: Homepage(),
  );
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

WeatherApiclient client = WeatherApiclient();
Weather? data;



  Future<void> getData() async{
    data = await client.getcurrentWeather("Thailand");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dream Up",
            style: GoogleFonts.marmelad(color: Colors.black, fontSize: 30)),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFf9f6ef),
      body: FutureBuilder(future: getData(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currentWeather(Icons.wb_sunny_rounded, "${data!.temp} ํ", "${data!.cityName}"),
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  "Additional Information" ,
                  style: TextStyle(
                    fontSize: 24.8,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 20.0
                ,),

                additionalInfo("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feels_like}")
              ],
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      )
    );
  }
}
