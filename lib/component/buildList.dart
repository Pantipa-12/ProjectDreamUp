import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildList extends StatelessWidget {
  final Color color;
  final String text;
  final bool add_btn;
  const BuildList(
      {super.key,
      required this.color,
      required this.text,
      required this.add_btn});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        add_btn
            ? CircleAvatar(
                backgroundColor: color,
                radius: 10,
                child: Text("+"),
              )
            : CircleAvatar(
                backgroundColor: color,
                radius: 10,
              ),
        SizedBox(width: 15),
        Text(
          text,
          style: GoogleFonts.marmelad(color: Colors.black, fontSize: 15),
        )
      ],
    );
  }
}