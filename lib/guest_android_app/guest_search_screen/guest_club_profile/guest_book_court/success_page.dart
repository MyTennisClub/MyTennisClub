import 'package:flutter/material.dart';

class Success_Main extends StatefulWidget {
  final String? date;
  final String? duration;
  final String? hour;
  final String? court;
  final String? endhour;
  const Success_Main(
      {this.date,
      this.duration,
      this.hour,
      this.court,
      this.endhour,
      super.key});

  @override
  State<Success_Main> createState() => SuccessMain();
}

class SuccessMain extends State<Success_Main> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color.fromRGBO(96, 218, 168, 1),
                    size: 137,
                  ),
                  const Center(
                    child: Text(
                      'Great!',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    'Your reservation was scheduled successfully',
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card.outlined(
                      color: const Color.fromRGBO(244, 246, 251, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Summary',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(29, 27, 32, 0.7))),
                              ],
                            ),
                            const Divider(
                              indent: 70,
                              endIndent: 70,
                              color: Colors.black,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Date',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2, child: Text('${widget.date}')),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Time',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          '${widget.hour} - ${widget.endhour}')),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 7.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Court',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 2, child: Text('${widget.court}')),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text(
                      'A QR for the Reservation has been \nadded to your profile',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 70),
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
                            .popUntil(ModalRoute.withName('/guest_home'));
                      },
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
