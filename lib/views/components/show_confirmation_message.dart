import 'package:flutter/material.dart';

showConfirmationMessage({
  required BuildContext context,
  required String title,
  required Function function,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              "CANCELAR",
            ),
          ),
          TextButton(
            onPressed: () {
              function();
              Navigator.of(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              "CONFIRMAR",
            ),
          ),
        ],
      );
    },
  );
}
