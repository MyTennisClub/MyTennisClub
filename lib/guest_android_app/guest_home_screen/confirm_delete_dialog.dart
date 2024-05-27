import 'package:flutter/material.dart';

class DeleteConfirmationDialog {
  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Reservation'),
          content: const Text('Are you sure you want to delete this reservation?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop('No');
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop('Yes');
              },
            ),
          ],
        );
      },
    );
  }
}