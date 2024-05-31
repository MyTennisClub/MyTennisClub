import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_config/flutter_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GuestsSearchScreen extends StatefulWidget {
  final Function checkClubSelected;
  const GuestsSearchScreen({required this.checkClubSelected, super.key});

  @override
  State<GuestsSearchScreen> createState() => _GuestsSearchScreenState();
}

class _GuestsSearchScreenState extends State<GuestsSearchScreen>
    with SingleTickerProviderStateMixin {
  Position? currentPosition;
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = {};
  LatLng _center = const LatLng(38.246266400032816, 21.735063818066433);

  final TextEditingController _searchController = TextEditingController();

  int? _value = 0;
  bool duration = true;
  List<List<dynamic>> _filteredData = [];
  var filterList = ['Covered', 'Grass', 'Has Equipment'];
  bool noResults = false;

  final List<List<dynamic>> clubList = [
    [
      0,
      'Patras Tennis Club',
      38.246266400032816,
      21.735063818066433,
      'Covered',
      'Hard',
      'Has Equipment',
      'Patras'
    ],
    [
      1,
      'Best Tennis Club',
      38.246229277552416,
      21.741915599979517,
      'Air',
      'Clay',
      'Has Equipment',
      'Patras'
    ],
    [
      2,
      'Tennis Center',
      38.252570180123946,
      21.739732137456364,
      'Covered',
      'Clay',
      'No Equipment',
      'Patras'
    ],
    [
      3,
      'Athens Tennis Club',
      37.940350236505475,
      23.708126122993432,
      'Air',
      'Grass',
      'No Equipment',
      'Athens'
    ],
    [
      4,
      'Athens Sports Center',
      37.994212105267394,
      23.724433953918993,
      'Air',
      'Hard',
      'Has Equipment',
      'Athens'
    ],
  ];

  // void getVariables() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await FlutterConfig.loadEnvVariables();
  // }

  @override
  void initState() {
    super.initState();

    _filteredData = clubList;
    for (int index = 0; index < _filteredData.length; index++) {
      markers.add(
        Marker(
            markerId: MarkerId(clubList[index][1]),
            infoWindow: InfoWindow(title: clubList[index][1]),
            position: LatLng(clubList[index][2], clubList[index][3])),
      );
    }
    _searchController.addListener(_performSearch);
  }

  // Future<void> _markersCheck() async {
  //   for (int index = 0; index < clubList.length; index++) {
  //     if (_filteredData.contains(clubList[index]) &&
  //         !markers.contains(clubList[index][1])) {
  //       print('add');
  //       markers.add(
  //         Marker(
  //             markerId: MarkerId(clubList[index][1]),
  //             infoWindow: InfoWindow(title: clubList[index][1]),
  //             position: LatLng(clubList[index][2], clubList[index][3])),
  //       );
  //     }
  //     if (!_filteredData.contains(clubList[index])) {
  //       print('remove');
  //       Marker marker = markers.firstWhere(
  //           (marker) => marker.markerId.value == clubList[index][1]);
  //       markers.remove(marker);
  //     }
  //   }
  // }

  Future<void> _performSearch() async {
    setState(() {
      noResults = false;
    });

    //Simulates waiting for an API call
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      _filteredData = clubList
          .where((row) => row[7]
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
      if (_filteredData.isEmpty) {
        noResults = true;
      }
    });
  }

  //google maps controller
  void _onMapCreated(GoogleMapController controller) async {
    mapController = mapController;
    await getLocation();
  }

  //create getLocation function
  Future<dynamic> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
        markers.add(Marker(
          markerId: const MarkerId('userLocation'),
          position:
              LatLng(currentPosition!.latitude, currentPosition!.longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
        ));
        _center = LatLng(currentPosition!.latitude, currentPosition!.longitude);
    }
  }

  @override
  void dispose() {
    mapController.future.then((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            // backgroundColor: const Color.fromRGBO(236, 238, 243, 10),
            automaticallyImplyLeading: false,
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(230, 232, 237, 1),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search regions',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                  ),
                ),
              ),
            )),
        body: LayoutBuilder(builder: (builder, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    textAlign: TextAlign.left,
                    'Filter Results',
                    style: TextStyle(
                        fontSize: 13, color: Color.fromRGBO(0, 0, 0, 0.7)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: List<Widget>.generate(
                      filterList.length,
                      (int i) {
                        return ChoiceChip(
                          selectedColor: const Color.fromRGBO(210, 230, 255, 1),
                          label: Text(filterList[i]),
                          selected: _value == i,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? i : null;
                              if (_value == null) {
                                noResults = false;
                                _performSearch();
                                // _markersCheck();
                              } else {
                                noResults = false;

                                _filteredData = _filteredData
                                    .where((row) => row.contains(filterList[i]))
                                    .toList();
                                //_markersCheck();
                                if (_filteredData.isEmpty) {
                                  noResults = true;
                                }
                              }
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: GoogleMap(
                        markers: markers,
                        gestureRecognizers: Set()
                          ..add(Factory<PanGestureRecognizer>(
                              () => PanGestureRecognizer()))
                          ..add(Factory<ScaleGestureRecognizer>(
                              () => ScaleGestureRecognizer()))
                          ..add(Factory<TapGestureRecognizer>(
                              () => TapGestureRecognizer()))
                          ..add(Factory<VerticalDragGestureRecognizer>(
                              () => VerticalDragGestureRecognizer())),
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.3,
                  child: (!noResults)
                      ? ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: _filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card.outlined(
                              color: const Color.fromRGBO(236, 238, 243, 1),
                              elevation: 1,
                              key: ObjectKey(clubList[index]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: const Icon(
                                      Icons.sports_tennis_outlined,
                                      size: 48.0,
                                      color: Colors.grey,
                                    ),
                                    title: Text(_filteredData[index][1],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    subtitle: Text(_filteredData[index][7]),
                                    trailing: FilledButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.checkClubSelected(
                                              true, _filteredData[index][0]);
                                        });
                                        // Handle button press
                                      },
                                      child: const Text('View'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : const Center(child: Text('No Results')),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
