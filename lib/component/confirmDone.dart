import 'package:compro/main.dart';
import 'package:compro/pages/first_page.dart';
import 'package:flutter/material.dart';

class ConfirmDone extends StatelessWidget {
  final Color color;
  final String text;
  final int id;

  const ConfirmDone({
    super.key,
    required this.color,
    required this.text,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure this todo-list is done?"),
      content: const Text("This operation will remove tido-list"),
      actions: [
        FilledButton(
            onPressed: () {
              if (percent < 1) {
                double pc = percent + (1 / 3);
                streamController.add(pc);
              } else {
                streamController.add(0);
              }

              streamControllerInt.add(id);
              Navigator.pop(context);
            },
            child: const Text("Confirm"))
      ],
    );
  }
}
