import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_config/flutter_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mytennisclub/models/clubList.dart';

class GuestsSearchScreen extends StatefulWidget {
  final Function checkClubSelected;
  final List<List<dynamic>> clubList;
  const GuestsSearchScreen(
      {required this.checkClubSelected, required this.clubList, super.key});

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

  bool isLoading = false;

  bool duration = true;
  List<List<dynamic>> _filteredData = [];
  List selectedFilters = [];
  List filters = [null, null, null];
  List filterNames = ['Covered', 'Grass', 'Has equipment'];
  bool noResults = false;

  late List<List<dynamic>> clubList = widget.clubList;

  @override
  void initState() {
    super.initState();
    _filteredData = clubList;
    print(_filteredData);

    _searchController.text = '';
    _searchController.addListener(_performSearch);
  }

  markersCheck() {
    setState(() {
      for (int index = 0; index < clubList.length; index++) {
        if (_filteredData.contains(clubList[index]) &&
            !markers.contains(clubList[index][1])) {
          print('add $index');
          markers.add(
            Marker(
                markerId: MarkerId(clubList[index][1]),
                infoWindow: InfoWindow(title: clubList[index][1]),
                position: LatLng(clubList[index][2], clubList[index][3])),
          );
        }
        if (!_filteredData.contains(clubList[index]) &&
            !markers.contains(clubList[index][1])) {
          print('remove $index');
          markers.removeWhere(
              (marker) => marker.markerId.value == clubList[index][1]);
        }
      }
    });
  }

  Future<void> _performSearch() async {
    setState(() {
      noResults = false;
      isLoading = true;
    });

    //Simulates waiting for an API call
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _filteredData = clubList
          .where((row) => row[4]
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
      if (_filteredData.isEmpty) {
        noResults = true;
      }
      markersCheck();
    });
    isLoading = false;
  }

  Future<void> performSearchwithFilters(covered, type, equipment) async {
    setState(() {
      noResults = false;
      isLoading = true;
    });
    print('wrong');
    //Simulates waiting for an API call
    await Future.delayed(const Duration(milliseconds: 200));
    List<List<dynamic>> filterCheck =
        await Clublist.retrieveClubs(covered, type, equipment);

    setState(() {
      _filteredData = filterCheck
          .where((row) => row[4]
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();

      if (_filteredData.isEmpty) {
        noResults = true;
      }
      markersCheck();
    });
    isLoading = false;
  }

  //google maps controller
  void _onMapCreated(GoogleMapController controller) async {
    mapController = mapController;
    await getLocation();

    for (int index = 0; index < _filteredData.length; index++) {
      markers.add(
        Marker(
            markerId: MarkerId(clubList[index][1]),
            infoWindow: InfoWindow(title: clubList[index][1]),
            position: LatLng(clubList[index][2], clubList[index][3])),
      );
    }
  }

  //create getLocation function
  Future<dynamic> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        markers.add(Marker(
          markerId: const MarkerId('userLocation'),
          position:
              LatLng(currentPosition!.latitude, currentPosition!.longitude),
          infoWindow: const InfoWindow(title: 'Your Location'),
        ));
        _center = LatLng(currentPosition!.latitude, currentPosition!.longitude);
      });
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
            forceMaterialTransparency:
                true, // backgroundColor: const Color.fromRGBO(236, 238, 243, 10),
            automaticallyImplyLeading: false,
            title: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
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
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          'Filter Results',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(0, 0, 0, 0.7)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 8.0,
                          children: List<Widget>.generate(
                            filterNames.length,
                            (int i) {
                              return ChoiceChip(
                                selectedColor:
                                    const Color.fromRGBO(210, 230, 255, 1),
                                label: Text(filterNames[i]),
                                selected: selectedFilters.contains(i),
                                onSelected: (bool selected) {
                                  setState(() {
                                    selectedFilters.contains(i)
                                        ? selectedFilters.remove(i)
                                        : selectedFilters.add(i);
                                    if (selectedFilters.isEmpty) {
                                      noResults = false;
                                      _performSearch();
                                    } else {
                                      print(selectedFilters);

                                      noResults = false;
                                      setState(() {
                                        if (selectedFilters.contains(0)) {
                                          filters[0] = true;
                                        } else {
                                          filters[0] = null;
                                        }
                                        if (selectedFilters.contains(1)) {
                                          filters[1] = 'GRASS';
                                        } else {
                                          filters[1] = null;
                                        }
                                        if (selectedFilters.contains(2)) {
                                          filters[2] = true;
                                        } else {
                                          filters[2] = null;
                                        }
                                      });
                                      print(filters);

                                      performSearchwithFilters(
                                          filters[0], filters[1], filters[2]);

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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: GoogleMap(
                          markers: markers,
                          gestureRecognizers: Set()
                            ..add(Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer()))
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (!noResults)
                          ? Expanded(
                              child: !isLoading
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(10),
                                      itemCount: _filteredData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Card.outlined(
                                          color: const Color.fromRGBO(
                                              236, 238, 243, 1),
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
                                                title: Text(
                                                    _filteredData[index][1],
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                subtitle: Text(
                                                    _filteredData[index][4]),
                                                trailing: FilledButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.checkClubSelected(
                                                          true,
                                                          _filteredData[index]
                                                              [0]);
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
                                  : SizedBox(
                                      height: constraints.maxHeight * 0.4,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ))
                          : SizedBox(
                              height: constraints.maxHeight * 0.4,
                              child: const Center(child: Text('No Results'))),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
