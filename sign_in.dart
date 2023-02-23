import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_demo/component/signin_butoon.dart';
import 'package:store_demo/component/squaretile.dart';
import 'package:store_demo/component/text_fied.dart';
import 'package:store_demo/pages/sign_up.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
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
      body: Column(children: [
        //icon app
        Padding(
          padding:
              const EdgeInsets.only(left: 80, right: 80, bottom: 30, top: 10),
          child: Image.asset(
            'lib/images/Logo/mainLogo.png',
            height: 150,
          ),
        ),

        //sign in text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Sign in to your account',
                style: GoogleFonts.marmelad(
                  color: Colors.black,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                )),
          ],
        ),

        //username text field
        MyTextfield(
          controller: emailController,
          hintText: 'Email : ',
          obscureText: false,
        ),

        //password text field
        MyTextfield(
          controller: passwordController,
          hintText: 'Password : ',
          obscureText: true,
        ),

        //forget password text
        Text('Forgot Password?',
            style: GoogleFonts.marmelad(
              color: Colors.black,
              fontSize: 18,
              decoration: TextDecoration.underline,
            )),

        //empty space
        const SizedBox(
          height: 20,
        ),

        //sign in button
        MyButton(
          onTap: signUserIn,
        ),

        //empty space
        const SizedBox(
          height: 20,
        ),

        //or with line
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'or with',
                    style: GoogleFonts.marmelad(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            )),

        //empty space
        const SizedBox(
          height: 20,
        ),

        //logo sign with
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            //google
            SquareTile(imagePath: 'lib/images/Logo/google.png'),

            SizedBox(width: 20),

            SquareTile(imagePath: 'lib/images/Logo/facebook.png')
          ],
        ),

        //empty space
        const SizedBox(height: 20),

        //don't have an account text
        Text("You dont't have an account?",
            style: GoogleFonts.marmelad(
              color: Colors.black,
              fontSize: 18,
            )),

        //sign up linked page
        GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const SignUpPage())),
          child: Text('sign up',
              style: GoogleFonts.marmelad(
                  color: Colors.black,
                  fontSize: 18,
                  decoration: TextDecoration.underline)),
        ),
      ]),
    );
  }
}
