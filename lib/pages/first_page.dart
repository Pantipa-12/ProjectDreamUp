import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:compro/animation/page1/coinTransition.dart';
import 'package:compro/animation/page1/moveCoin.dart';
import 'package:compro/component/bar.dart';
import 'package:compro/component/buildList.dart';
import 'package:compro/component/coin.dart';
import 'package:compro/pages/calender_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    super.key,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

String? _dropdownValue = "Big";
List<String> dropdownList = ["Big", "Normal", "Small"];
String lv = 'lib/images/LV0.png';
final _formKey = GlobalKey<FormState>();
String title = "";
String describe = "";
Color color = Colors.black;
List<Widget> listOfWidget = [];
int money = 0;
double percent = 0;
int _selectedIndex = 0;

//Animation Variable/////
bool bounce = true;
bool animateCoin = true;
double opacityLevel = 1.0;
bool sizeCoin = true;
bool sizeImage = true;
bool fadeOutBig = false;
/////////////////////////

///Listview Variable/////
List<Widget> listOfListView = [];
/////

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  late AnimationController animationController;

  void _onTap() {
    switch (_selectedIndex) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Calender(money: money)));
    }
  }

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
                  widget: Coin(imagePath: 'lib/images/coin.png', money: money),
                  animationController: animationController),
              Coin(imagePath: 'lib/images/coin.png', money: money),
            ],
          ),
        ],
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFf9f6ef),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.centerLeft,
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
                  child: SlidableAutoCloseBehavior(
                    closeWhenOpened: true,
                    child: ReorderableListView(
                        buildDefaultDragHandles: false,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex--;

                            final item = listOfListView.removeAt(oldIndex);
                            listOfListView.insert(newIndex, item);
                          });
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        children: [
                          for (int index = 0;
                              index < listOfListView.length;
                              index++)
                            ReorderableDragStartListener(
                              key: ValueKey(listOfListView[index]),
                              index: index,
                              child: Padding(
                                key: ValueKey(listOfListView[index]),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Slidable(
                                    closeOnScroll: false,
                                    startActionPane: ActionPane(
                                        motion: const StretchMotion(),
                                        children: [
                                          SlidableAction(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              padding: const EdgeInsets.all(10),
                                              backgroundColor:
                                                  Colors.red.shade300,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                              onPressed: (context) =>
                                                  _onRemove(index)),
                                          SlidableAction(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              padding: const EdgeInsets.all(10),
                                              backgroundColor:
                                                  Colors.yellow.shade300,
                                              icon: Icons.edit,
                                              label: 'Edit',
                                              onPressed: (context) =>
                                                  _onEdit(context, index))
                                        ]),
                                    endActionPane: ActionPane(
                                        motion: const BehindMotion(),
                                        children: [
                                          SlidableAction(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              padding: const EdgeInsets.all(10),
                                              backgroundColor:
                                                  Colors.green.shade300,
                                              icon: Icons.done,
                                              label: 'Done',
                                              onPressed: (context) =>
                                                  _onDone(index))
                                        ]),
                                    child: listOfListView[index]),
                              ),
                            )
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: (() => openDialog(context)),
                        child: const Icon(Icons.add),
                      )
                    ],
                  ),
                ),
              ],
            ),
            moveCoin(
                opacity: opacityLevel,
                widget: Image.asset('lib/images/coin.png'),
                sizeBool: sizeImage,
                moveBool: animateCoin,
                duration: const Duration(seconds: 3),
                alignmentX: -1.25,
                alignmentY: 1.25),
            moveCoin(
                opacity: opacityLevel,
                widget: Image.asset('lib/images/coin.png'),
                sizeBool: sizeImage,
                moveBool: animateCoin,
                duration: const Duration(seconds: 4),
                alignmentX: -1.25,
                alignmentY: 1.25),
            moveCoin(
                opacity: opacityLevel,
                widget: Image.asset('lib/images/coin.png'),
                sizeBool: sizeImage,
                moveBool: animateCoin,
                duration: const Duration(seconds: 5),
                alignmentX: -1.25,
                alignmentY: 1.25),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFfff0cc),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: (value) => _onTap(),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset("lib/images/calender.PNG",
                    width: 40, height: 30, fit: BoxFit.fitWidth),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset("lib/images/basket.png",
                    width: 40, height: 30, fit: BoxFit.fitWidth),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "lib/images/cloud.PNG",
                  width: 40,
                  height: 30,
                  fit: BoxFit.fitWidth,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset("lib/images/person.PNG",
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
                    height: 250,
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
                              title = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter Describe",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Describe can't be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              describe = value;
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
                            if (_dropdownValue == dropdownList[0]) {
                              color = Colors.purple.shade200;
                            } else if (_dropdownValue == dropdownList[1]) {
                              color = Colors.green.shade200;
                            } else if (_dropdownValue == dropdownList[2]) {
                              color = Colors.brown.shade200;
                            }

                            setState(() {
                              listOfListView.add(BuildList(
                                  toDoList: ToDoList(
                                      title: title,
                                      describe: describe,
                                      color: color)));
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
      'lib/images/LV0.png',
      'lib/images/LV1.gif',
      'lib/images/LV2.gif',
      'lib/images/LV3.gif'
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

        Future.delayed(const Duration(milliseconds: 2500), () {
          animationController.forward();
          Future.delayed(const Duration(milliseconds: 800), () {
            animationController.forward();
            Future.delayed(const Duration(milliseconds: 800), () {
              animationController.forward();
            });
          });
        });
      }
    });
  }

  void _onDone(int index) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Are you sure this todo-list is done?"),
            content: const Text("This operation will remove tido-list"),
            actions: [
              FilledButton(
                  onPressed: () {
                    if (percent < 1) {
                      double pc = percent + (1 / 3);
                      setPercent(pc);
                    } else {
                      setPercent(0);
                    }

                    _onRemove(index);
                    Navigator.pop(context);
                  },
                  child: const Text("Confirm"))
            ],
          ));

  void _onEdit(context, index) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setDiaState) => Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AlertDialog(
                  title: const Text("Edit To Do List"),
                  content: SizedBox(
                    width: 200,
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter title",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Title can't be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Enter Describe",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Describe can't be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              describe = value;
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
                            _onRemove(index);
                            listOfListView.insert(
                                index,
                                BuildList(
                                    toDoList: ToDoList(
                                        title: title,
                                        describe: describe,
                                        color: color)));

                            Navigator.pop(context);
                          }
                        },
                        child: const Text("OK")),
                  ],
                ),
              )));

  void _onRemove(int int) {
    setState(() {
      listOfListView.removeAt(int);
    });
  }
}

class ToDoList {
  String title;
  String describe;
  Color color;

  ToDoList({required this.title, required this.describe, required this.color});

  void setText(String text) {
    title = text;
  }

  void setDescribe(String text) {
    describe = text;
  }
}
