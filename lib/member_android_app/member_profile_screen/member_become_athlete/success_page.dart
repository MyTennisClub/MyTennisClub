import 'package:flutter/material.dart';

class Success_Page extends StatefulWidget {
  const Success_Page({super.key});

  @override
  State<Success_Page> createState() => SuccessPage();
}

class SuccessPage extends State<Success_Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Color.fromRGBO(96, 218, 168, 1),
                size: 137,
              ),
              Text(
                'Great!',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                'Your application was completed successfully',
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 83, 135, 1)
                        // This is what you need!
                        ),
                    onPressed: () {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName('/member_home'));
                    },
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
