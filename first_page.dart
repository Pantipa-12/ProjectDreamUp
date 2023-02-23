import 'dart:collection';
import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animation/coinTransition.dart';
import '../animation/moveCoin.dart';
import '../component/bar.dart';
import '../component/buildList.dart';
import '../component/coin.dart';
import 'package:confetti/confetti.dart';

class FirstPage extends StatefulWidget {
  final Stream<double> stream;
  final Stream<int> streamRemoveList;

  const FirstPage({
    super.key,
    required this.stream,
    required this.streamRemoveList,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

String? _dropdownValue = "Resolution";
List<String> dropdownList = ["Resolution", "Daily"];
String lv = 'lib/images/Logo/LV0.png';
final _formKey = GlobalKey<FormState>();
String textList = "";
List<Widget> listOfWidget = [];
int money = 0;
double percent = 0;

//Animation Variable/////
bool bounce = true;
bool animateCoin = true;
double opacityLevel = 1.0;
bool sizeCoin = true;
bool sizeImage = true;
bool confetti = false;
/////////////////////////
///Listview Variable/////
Map<int, Widget> mapOfListView = {};
/////

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  final confettiController = ConfettiController();

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
        }
      });
    super.initState();
    confettiController.addListener(() {
      setState(() {
        confetti = confettiController.state == ConfettiControllerState.playing;
      });
    });
    widget.streamRemoveList.listen((int) {
      removeList(int);
    });
    widget.stream.listen((pc) {
      setPercent(pc);
    });
    mapOfListView[999] = GestureDetector(
      onTap: () {
        openDialog(context);
      },
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.brown,
            radius: 10,
            child: Text(
              "+",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
          Text(
            '',
            style: GoogleFonts.marmelad(color: Colors.black, fontSize: 15),
          )
        ],
      ),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Dream Up",
            style: GoogleFonts.marmelad(color: Colors.black, fontSize: 30)),
        actions: [
          Stack(
            children: [
              coinTransiton(
                  widget: Coin(
                      imagePath: 'lib/images/Stickers/coin.png', money: money),
                  animationController: animationController),
              Coin(imagePath: 'lib/images/Stickers/coin.png', money: money),
            ],
          ),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFf9f6ef),
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Bar(
                    percent: percent,
                  ),
                  const SizedBox(height: 20),
                  Pulse(
                      animate: bounce,
                      child: Image.asset(
                        lv,
                        width: 200,
                        height: 200,
                      )),
                  const SizedBox(height: 30),
                  Text("To Do Lists",
                      style: GoogleFonts.marmelad(
                          color: Colors.black, fontSize: 30)),
                  const SizedBox(height: 25),
                  Expanded(
                    child: ListView.builder(
                      itemCount: mapOfListView.length,
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      itemBuilder: (context, index) {
                        var keys = mapOfListView.keys.toList();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: mapOfListView[keys[index]],
                        );
                      },
                    ),
                  ),
                ],
              ),
              moveCoin(
                  opacity: opacityLevel,
                  widget: Image.asset('lib/images/Stickers/coin.png'),
                  sizeBool: sizeImage,
                  moveBool: animateCoin,
                  duration: const Duration(seconds: 3),
                  alignmentX: -1.25,
                  alignmentY: 1.25),
              moveCoin(
                  opacity: opacityLevel,
                  widget: Image.asset('lib/images/Stickers/coin.png'),
                  sizeBool: sizeImage,
                  moveBool: animateCoin,
                  duration: const Duration(seconds: 4),
                  alignmentX: -1.25,
                  alignmentY: 1.25),
              moveCoin(
                  opacity: opacityLevel,
                  widget: Image.asset('lib/images/Stickers/coin.png'),
                  sizeBool: sizeImage,
                  moveBool: animateCoin,
                  duration: const Duration(seconds: 5),
                  alignmentX: -1.25,
                  alignmentY: 1.25),
              /*  ConfettiWidget(
                confettiController: confettiController,
                shouldLoop: true,
                emissionFrequency: 0.001,
                gravity: 0.02,
                numberOfParticles: 40,
                blastDirectionality: BlastDirectionality.explosive,
                colors: const [Colors.amber, Colors.lightBlue, Colors.grey],
              )*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFfff0cc),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset("lib/images/Logo/calendar.PNG",
                    width: 40, height: 30, fit: BoxFit.fitWidth),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset("lib/images/Logo/basket.PNG",
                    width: 40, height: 30, fit: BoxFit.fitWidth),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/images/Logo/cloud.PNG",
                  width: 40,
                  height: 30,
                  fit: BoxFit.fitWidth,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset("lib/images/Logo/person.PNG",
                    width: 25, height: 30, fit: BoxFit.fitWidth),
                label: ""),
          ]),
    );
  }

  void openDialog(context) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setDiaState) => Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AlertDialog(
                  title: const Text("Add To Do List"),
                  content: SizedBox(
                    width: 200,
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter Text",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Name can't be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              textList = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              isExpanded: true,
                              buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.black26),
                                  color: Colors.amber.shade100),
                              items: dropdownList
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      ))
                                  .toList(),
                              value: _dropdownValue,
                              onChanged: (value) => setDiaState(() {
                                    _dropdownValue = value;
                                  })),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    FilledButton(
                        onPressed: () {
                          final isValidForm = _formKey.currentState!.validate();
                          if (isValidForm) {
                            Color color = Colors.brown;

                            if (_dropdownValue == dropdownList[0]) {
                              color = Colors.purple.shade200;
                            } else if (_dropdownValue == dropdownList[1]) {
                              color = Colors.brown.shade200;
                            }
                            setState(() {
                              mapOfListView[mapOfListView.length + 1] =
                                  BuildList(
                                color: color,
                                text: textList,
                                id: mapOfListView.length + 1,
                              );

                              mapOfListView = SplayTreeMap<int, Widget>.from(
                                  mapOfListView, (k1, k2) => k1.compareTo(k2));
                            });

                            Navigator.pop(context);
                          }
                        },
                        child: const Text("OK")),
                  ],
                ),
              )));
  void setPercent(double pc) {
    List<String> image = [
      'lib/images/Logo/LV0.png',
      'lib/images/Logo/LV1.gif',
      'lib/images/Logo/LV2.gif',
      'lib/images/Logo/LV3.gif'
    ];
    setState(() {
      percent = pc;
      if (percent == 0) {
        lv = image[0];
        opacityLevel = 0;
        animateCoin = !animateCoin;
        bounce = !bounce;
      } else if (percent == (1 / 3)) {
        bounce = !bounce;
        sizeImage = true;
        opacityLevel = 1;
        lv = image[1];
      } else if (percent == (2 / 3)) {
        lv = image[2];
        bounce = !bounce;
      } else if (percent == 1) {
        lv = image[3];
        bounce = !bounce;
        money = money + 3;
        animateCoin = !animateCoin;
        opacityLevel = 0;
        sizeImage = false;
        confettiController.play();

        Future.delayed(const Duration(milliseconds: 2500), () {
          animationController.forward();
          Future.delayed(const Duration(milliseconds: 800), () {
            animationController.forward();
            Future.delayed(const Duration(milliseconds: 800), () {
              animationController.forward();
              confettiController.stop();
            });
          });
        });
      }
    });
  }

  void removeList(int int) {
    setState(() {
      mapOfListView.remove(int);
      mapOfListView = mapOfListView;
    });
  }
}
