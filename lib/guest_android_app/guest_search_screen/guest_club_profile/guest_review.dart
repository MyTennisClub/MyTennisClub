import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GuestReview extends StatefulWidget {
  const GuestReview({super.key});

  @override
  State<GuestReview> createState() => _GuestReviewState();
}

class _GuestReviewState extends State<GuestReview> {
  String _errorText = '';
  String review = '';
  String userRating = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Review Club'),
          ),
          body: LayoutBuilder(builder: (builder, contraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: contraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Review of:',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Patras Tennis Club',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            RatingBar.builder(
                                glow: false,
                                itemSize: 19,
                                initialRating: 3,
                                itemCount: 5,
                                allowHalfRating: true,
                                itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color.fromRGBO(255, 195, 116, 1)),
                                onRatingUpdate: (rating) {}),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Write your thoughts (optional)'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.all(25),
                          errorText: _errorText.isEmpty ? null : _errorText,
                        ),
                        keyboardType: TextInputType.name,
                        maxLines: 8,
                        onChanged: (value) {
                          setState(() {
                            if (value.length >= 150) {
                              _errorText =
                                  'You have reached the limit of 150 characteres';
                            } else {
                              review = value;
                              _errorText = '';
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              (_errorText.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop(['Nikos', review]);
                        },
                        // ignore: prefer_const_constructors
                        child: Text('Submit'),
                      ),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
