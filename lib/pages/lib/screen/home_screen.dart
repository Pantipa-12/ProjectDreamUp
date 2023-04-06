import 'dart:convert';

import 'package:dreamup2/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather> fetchWeather() async {
    final resp = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Bangkok&appid=a3e49be4f8f578e46a5689a443d85584&units=metric"));

    if (resp.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(resp.body);

      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load data');
    }
  }

  late Future<Weather> myWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myWeather = fetchWeather();
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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 30.0,
        ),
        child: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<Weather>(
              future: myWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data!.name,
                          style: GoogleFonts.marmelad(
                              color: Colors.black, fontSize: 30)),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        snapshot.data!.weather[0]['main'].toString(),
                        style: GoogleFonts.marmelad(
                            color: Colors.black, fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 250,
                        width: 250,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            '/Users/anyamaneekss/Documents/dreamup/dreamup2/dreamup2/asset/icon/cloudy2.png',
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Temperature',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${((snapshot.data!.main['temp']))}°C',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              const Text(
                                'Wind',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('${snapshot.data!.wind['speed']} km/h', style: const TextStyle(
                                color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                              ),),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              const Text('Humidity',
                              style: TextStyle(
                                color: Colors.black,
                                  fontSize: 17,
                              ),),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('${snapshot.data!.main['humidity']}%', style: const TextStyle(
                                color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700
                              ),)
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text('Failed to load data');
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
