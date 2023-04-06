import 'package:dreamup2/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override

  void initStat(){
    Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.push(context, 
    MaterialPageRoute(builder: (context) => const HomeScreen())));
    super.initState();
  }
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            height: 250,
            width: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(fit: BoxFit.contain,
              image: AssetImage('/Users/anyamaneekss/Documents/dreamup/dreamup2/dreamup2/asset/icon/cloudy2.png'))
            ),
          ),
        ),
      ),
    );
  }
}