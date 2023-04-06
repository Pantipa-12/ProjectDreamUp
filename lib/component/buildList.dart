import 'package:compro/pages/first_page.dart';
import 'package:flutter/material.dart';

class BuildList extends StatelessWidget {
  ToDoList toDoList;

  BuildList({super.key, required this.toDoList});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        leading: CircleAvatar(
          backgroundColor: toDoList.color,
          radius: 13,
        ),
        title: Text(
          toDoList.title,
          style: const TextStyle(fontSize: 24),
        ),
        subtitle: Text(toDoList.describe),
        isThreeLine: true,
      ),
    );
  }
}
