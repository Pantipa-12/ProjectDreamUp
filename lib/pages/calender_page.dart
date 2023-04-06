import 'dart:html';
import 'dart:math';

import 'package:compro/component/coin.dart';
import 'package:compro/pages/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:compro/utils/utils.dart';

class Calender extends StatefulWidget {
  final int money;
  const Calender({super.key, required this.money});

  @override
  State<Calender> createState() => _CalenderState();
}

final _formKey = GlobalKey<FormState>();
String title = "";

class _CalenderState extends State<Calender> {
  late Map<DateTime, List<Event>> kEvent;
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

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
                      kEvent[_selectedDay]?.add(Event(title));
                    } else {
                      kEvent[_selectedDay] = [Event(title)];
                    }
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
      );

  @override
  void initState() {
    kEvent = {};
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
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
        child: FloatingActionButton(
          onPressed: () => showAddEvent(_selectedDay),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TableCalendar<Event>(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
              (Event event) => SlidableAutoCloseBehavior(
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
                          onPressed: (context) => _onEdit(_selectedDay, event))
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
                        event.title,
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
                    int index = kEvent[key]!.indexOf(event);
                    setState(() {
                      kEvent[key]![index] = Event(title);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
      );
}
