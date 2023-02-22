import 'package:compro/component/confirmDone.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildList extends StatelessWidget {
  final Color color;
  final String text;
  final int id;

  const BuildList(
      {super.key, required this.color, required this.text, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) =>
                ConfirmDone(color: color, text: text, id: id));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 10,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: GoogleFonts.marmelad(color: Colors.black, fontSize: 15),
          )
        ],
      ),
    );
  }
}
