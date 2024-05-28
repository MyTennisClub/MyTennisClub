import 'package:flutter/material.dart';
import 'package:mytennisclub/secretary_android_app/secretary_qr/qr_info.dart';
import 'package:mytennisclub/secretary_android_app/secretary_qr/qr_scan.dart';

class Secretary_Scan extends StatefulWidget {
  const Secretary_Scan({super.key});

  @override
  State<Secretary_Scan> createState() => SecretaryScan();
}

class SecretaryScan extends State<Secretary_Scan> {
  int currentPageIndex = 0;
  String result = '';

  checkResult(newResult) {
    setState(() {
      result = newResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(236, 238, 243, 1),
        title: const Text('MyTennisClub',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.notifications_outlined,
                size: 27,
              ),
              tooltip: 'Show Notifications',
            ),
          ),
        ],
      ),
      body: <Widget>[
        LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.qr_code_scanner_outlined,
                      size: 137,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 80.0),
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(0, 83, 135, 1)
                            // This is what you need!
                            ),
                        onPressed: () async {
                          await showModalBottomSheet<List<String>>(
                            isDismissible: false,
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SizedBox(
                                height: constraints.maxHeight,
                                child: QR_Scan(checkResult: checkResult)),
                          );
                          setState(() {
                            print(result);
                            if (result.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => QR_Info(
                                    result: result,
                                  ),
                                ),
                              );
                            }
                          });
                        },
                        child: const Text('Scan QR'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const Center(
          child: Text('Profile'),
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromRGBO(210, 230, 255, 1),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    ));
  }
}
