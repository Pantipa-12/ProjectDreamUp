import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_demo/pages/sign_in.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
          Text('Create your account',
              style: GoogleFonts.marmelad(
                color: Colors.black,
                fontSize: 30,
                decoration: TextDecoration.underline,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'User name : ',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Password : ',
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
                hintText: 'Confirm Password : ',
                // hintStyle:
                //     GoogleFonts.marmelad(color: Colors.black, fontSize: 18),
                filled: true,
                fillColor: Colors.deepPurple[50],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.deepPurple, width: 2)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SignInPage()));
              },
              child: const Text(
                'Sign up',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
          ),
        ]));
  }
}
