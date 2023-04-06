import 'dart:convert';
import 'dart:io';

import 'package:compro/component/coin.dart';
import 'package:compro/pages/first_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:compro/utils/utils.dart';

class Calender extends StatefulWidget {
  final int money;
  const Calender({super.key, required this.money});

  @override
  State<Calender> createState() => _CalenderState();
}

final Map<String, String> sticker = {
  "cake": "lib/images/Stickers/cake.png",
  "cat": "lib/images/Stickers/cat.png",
  "dog": "lib/images/Stickers/dog.png"
};

final _formKey = GlobalKey<FormState>();
String title = "";

var _x = 0.0;
var _y = 0.0;
final GlobalKey stackKey = GlobalKey();

final List<String> dropdown = ['Add event', 'Add sticker'];
int? selectedSticker;
bool showDrag = false;

class _CalenderState extends State<Calender> {
  late Map<DateTime, dynamic> kEvent;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late SharedPreferences prefs;

  void showAddEvent(DateTime? dateTime) => showDialog(
        context: context,
        builder: (context) => Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AlertDialog(
            title: const Text("Add Event"),
            content: SizedBox(
              width: 100,
              child: TextFormField(
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
            ),
            actions: [
              FilledButton(
                  onPressed: () {
                    if (kEvent[_selectedDay] != null) {
                      kEvent[_selectedDay]?.add(title);
                    } else {
                      kEvent[_selectedDay] = [title];
                    }
                    setState(() {
                      prefs.setString("events", json.encode(encodeMap(kEvent)));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
      );

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key]!;
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key]!;
    });
    return newMap;
  }

  prefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      kEvent = Map<DateTime, dynamic>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  @override
  void initState() {
    super.initState();

    kEvent = {};
    _selectedDay = _focusedDay;
    prefsData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return kEvent[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Dream Up",
            style: TextStyle(color: Colors.black, fontSize: 30)),
        actions: [
          Coin(imagePath: 'lib/images/coin.png', money: money),
        ],
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFf9f6ef),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            dropdownWidth: 160,
            dropdownDirection: DropdownDirection.left,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 255, 248, 230)),
            customButton: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 15,
                        offset: Offset(0, 5))
                  ],
                  color: const Color.fromARGB(255, 255, 231, 174),
                  borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.add),
            ),
            items: dropdown
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                switch (value) {
                  case "Add event":
                    showAddEvent(_selectedDay);
                    break;
                  case "Add sticker":
                    showSticker();
                    break;
                }
              });
            },
            buttonDecoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Stack(
          key: stackKey,
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TableCalendar<dynamic>(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      calendarFormat: _calendarFormat,
                      rangeSelectionMode: _rangeSelectionMode,
                      eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      headerStyle: const HeaderStyle(
                          decoration: BoxDecoration(color: Color(0xFFfff0cc)),
                          headerMargin: EdgeInsets.only(bottom: 8)),
                      calendarStyle: const CalendarStyle(
                        outsideDaysVisible: false,
                      ),
                      onDaySelected: _onDaySelected,
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    ..._getEventsForDay(_selectedDay).map(
                      (dynamic event) => SlidableAutoCloseBehavior(
                        closeWhenOpened: true,
                        child: Slidable(
                          closeOnScroll: false,
                          startActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                  borderRadius: BorderRadius.circular(20),
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.red.shade300,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (context) =>
                                      _onRemove(_selectedDay, event)),
                              SlidableAction(
                                  borderRadius: BorderRadius.circular(20),
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.yellow.shade300,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  onPressed: (context) =>
                                      _onEdit(_selectedDay, event))
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 255, 248, 230),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5))
                                ]),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.orange,
                                radius: 12,
                              ),
                              title: Text(
                                event,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                DateFormat.yMMMMEEEEd().format(_selectedDay),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            showDrag
                ? Positioned(
                    left: _x,
                    top: _y,
                    child: Draggable(
                      feedback: displaySticker(selectedSticker!),
                      childWhenDragging: Container(),
                      onDragEnd: (dragdetails) {
                        setState(() {
                          final parentPos = stackKey.globalPaintBounds;
                          if (parentPos == null) return;
                          _x = dragdetails.offset.dx - parentPos.left;
                          _y = dragdetails.offset.dy - parentPos.top;
                        });
                      },
                      child: displaySticker(selectedSticker!),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFfff0cc),
          showSelectedLabels: false,
          showUnselectedLabels: false,
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

  void _onRemove(key, event) {
    Map<DateTime, dynamic> map = Map<DateTime, dynamic>.from(
        decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    map[key]?.remove(event);
    prefs.setString("events", json.encode(encodeMap(map)));

    setState(() {
      kEvent[key]?.remove(event);
    });
  }

  void _onEdit(key, event) => showDialog(
        context: context,
        builder: (context) => Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AlertDialog(
            title: const Text("Edit Event"),
            content: SizedBox(
              width: 100,
              child: TextFormField(
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
            ),
            actions: [
              FilledButton(
                  onPressed: () {
                    Map<DateTime, dynamic> map = Map<DateTime, dynamic>.from(
                        decodeMap(
                            json.decode(prefs.getString("events") ?? "{}")));
                    int index = kEvent[key]!.indexOf(event);
                    map[key]![index] = title;
                    prefs.setString("events", json.encode(encodeMap(map)));

                    setState(() {
                      kEvent[key]![index] = title;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
      );

  void showSticker() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Add sticker'),
            content: SizedBox(
              width: 100,
              height: 200,
              child: ListView.builder(
                itemCount: sticker.length,
                itemBuilder: (context, index) {
                  String key = sticker.keys.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSticker = index;
                        showDrag = true;
                      });
                      Navigator.pop(context);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.asset(
                          "${sticker[key]}",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(key),
                      ),
                    ),
                  );
                },
              ),
            ),
          ));

  Widget displaySticker(int index) {
    String key = sticker.keys.elementAt(index);
    return Image.asset("${sticker[key]}", width: 60, height: 50);
  }
}

extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}
