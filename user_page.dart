import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

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
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 80, right: 80, bottom: 30, top: 10),
          child: Image.asset(
            'lib/images/Logo/mainLogo.png',
            height: 200,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'User name : ',
              hintStyle:
                  GoogleFonts.marmelad(color: Colors.grey[800], fontSize: 18),
              filled: true,
              fillColor: Colors.deepPurple[50],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Ultimate Goal : ',
              // hintStyle:
              //     GoogleFonts.marmelad(color: Colors.black, fontSize: 18),
              filled: true,
              fillColor: Colors.deepPurple[50],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: 'Email : ',
              // hintStyle:
              //     GoogleFonts.marmelad(color: Colors.black, fontSize: 18),
              filled: true,
              fillColor: Colors.deepPurple[50],
            ),
          ),
        ),
      ]),
    );
  }
}
