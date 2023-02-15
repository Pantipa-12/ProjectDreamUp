import 'package:compro/component/buildList.dart';
import 'package:compro/component/coin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dream Up",
            style: GoogleFonts.marmelad(color: Colors.black, fontSize: 30)),
        actions: [Coin(imagePath: 'lib/images/coin.png')],
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFf9f6ef),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.network(
                  "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"),
              SizedBox(height: 30),
              Text("To Do Lists",
                  style:
                      GoogleFonts.marmelad(color: Colors.black, fontSize: 30)),
              SizedBox(height: 25),
              Container(
                width: 200,
                height: 140,
                child: ListView.separated(
                  itemCount: 20,
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    return BuildList(
                        color: Colors.black,
                        text: "Got to the parkaasd",
                        add_btn: false);
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: 200,
                  child: BuildList(
                    color: Colors.brown,
                    text: "",
                    add_btn: true,
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFFfff0cc),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.sunny,
                  color: Colors.black,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: ""),
          ]),
    );
  }
}
