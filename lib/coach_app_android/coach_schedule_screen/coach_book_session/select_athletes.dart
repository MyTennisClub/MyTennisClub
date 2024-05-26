import 'package:flutter/material.dart';

class Select_Athletes extends StatefulWidget {
  const Select_Athletes({super.key});

  @override
  State<Select_Athletes> createState() => SelectAthletes();
}

class SelectAthletes extends State<Select_Athletes> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> athleteList = [
    'Cataleya Ho',
    'Melissa Roth',
    'Morgan Reyes',
    'Elliot Quinn',
    'Estrella Escobar',
    'Ace Terell',
    'Carter Spencer',
    'Patrick Dyer',
    'Jonas Wiley'
  ];
  List<int> selectedItems = [];
  List<String> _filteredData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filteredData = athleteList;
    _searchController.addListener(_performSearch);
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
    });

    //Simulates waiting for an API call
    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _filteredData = athleteList
          .where((element) => element
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(248, 249, 255, 1),
            ),
          ),
          title: TextField(
            controller: _searchController,
            style: const TextStyle(color: Color.fromRGBO(29, 27, 32, 0.7)),
            cursorColor: const Color.fromRGBO(29, 27, 32, 0.7),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle:
                  const TextStyle(color: Color.fromRGBO(29, 27, 32, 0.7)),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected: ${selectedItems.length}/3',
                        textAlign: TextAlign.start,
                      ),
                      ListView.builder(
                        primary: true,
                        itemCount: _filteredData.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(29, 27, 32, 0.574)),
                              ),
                              color: (selectedItems.contains(index))
                                  ? const Color.fromRGBO(210, 230, 255, 2)
                                  : Colors.transparent),
                          child: ListTile(
                            onTap: () {
                              if (selectedItems.contains(index)) {
                                setState(() => selectedItems
                                    .removeWhere((val) => val == index));
                              }
                            },
                            onLongPress: () {
                              if (!selectedItems.contains(index) &&
                                  selectedItems.length < 3) {
                                setState(() => selectedItems.add(index));
                              }
                            },
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: (!selectedItems.contains(index))
                                  ? const Color.fromRGBO(50, 121, 180, 1)
                                  : const Color.fromRGBO(52, 75, 98, 1),
                              child: (!selectedItems.contains(index))
                                  ? Text(
                                      '${athleteList[index][0]}${athleteList[index][1].toUpperCase()}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  : const Icon(Icons.check,
                                      size: 20, color: Colors.white),
                            ),
                            title: Text(
                              _filteredData[index],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color.fromRGBO(50, 121, 180, 1),
          label: const Text.rich(TextSpan(children: <InlineSpan>[
            WidgetSpan(
              child: Icon(
                Icons.check,
                size: 18,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: '  Save',
              style: TextStyle(color: Colors.white),
            )
          ])),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
