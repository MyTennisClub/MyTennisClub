import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_review.dart';
import 'package:mytennisclub/models/guest.dart';

class ClubReview extends StatefulWidget {
  final List clubReviews;
  final int guestID;
  final int clubID;
  const ClubReview(
      {required this.clubReviews,
      required this.clubID,
      required this.guestID,
      super.key});

  @override
  State<ClubReview> createState() => _ClubReviewState();
}

class _ClubReviewState extends State<ClubReview> {
  late List<int> likes = [];

  @override
  void initState() {
    print(widget.guestID);
    for (int index = 0; index < widget.clubReviews.length; index++) {
      likes.add(widget.clubReviews[index][2]);
    }
  }
  // List<String> dates = [
  //   DateFormat.yMMMMd().format(DateTime.now()),
  //   DateFormat.yMMMMd().format(DateTime.utc(2024, 3, 5)),
  //   DateFormat.yMMMMd().format(DateTime.utc(2024, 5, 3))
  // ];
  // List<String> review = [
  //   "Body text for a post. Since it’s a social app, sometimes it’s a hot take, and sometimes it’s a question.",
  //   "Body text for a post. Since it’s a social app, sometimes it’s a hot take, and sometimes it’s a question.",
  //   "Body text for a post. Since it’s a social app, sometimes it’s a hot take, and sometimes it’s a question."
  // ];

  late List<bool> likePressed = List<bool>.generate(
      widget.clubReviews.length, (int index) => false,
      growable: true);
  List<String>? newReview = [];

  Future<void> _openReview(context) async {
    var result = showModalBottomSheet<List<String>>(
      isDismissible: false,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => GuestReview(
        guestID: widget.guestID,
        clubID: widget.clubID,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.90,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.clubReviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        key: ObjectKey(
                          widget.clubReviews[index],
                        ), // Using the item's value as the key.
                        color: const Color.fromRGBO(244, 246, 251, 1),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 17,
                                    backgroundColor:
                                        const Color.fromRGBO(50, 121, 180, 1),
                                    child: Text(
                                      widget.clubReviews[index][0][0],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (widget.clubReviews[index][1] !=
                                                  widget.guestID)
                                              ? widget.clubReviews[index][0]
                                              : 'Your review',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          DateFormat.yMMMMd().format(
                                              widget.clubReviews[index][5]),
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  130, 130, 130, 1),
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.clubReviews[index][3].toString(),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(29, 27, 32, 0.7),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    (likePressed[index] == false)
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Guest.addLike(
                                                    widget.clubReviews[index]
                                                        [1],
                                                    widget.clubID);
                                                likePressed[index] = true;
                                                likes[index]++;
                                              });
                                            },
                                            child: const Icon(
                                                Icons.favorite_border_outlined,
                                                size: 20),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                Guest.removeLike(
                                                    widget.clubReviews[index]
                                                        [1],
                                                    widget.clubID);

                                                likePressed[index] = false;
                                                likes[index]--;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.favorite,
                                              size: 20,
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '${likes[index]} Likes',
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(29, 27, 32, 0.7),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                indent: 30,
                                endIndent: 40,
                                color: Color.fromRGBO(193, 199, 209, 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: constraints.maxWidth * 0.50,
                      child: FilledButton(
                          onPressed: () async {
                            _openReview(context);
                            // print(newReview![0]);
                            // print(newReview![1]);
                            // names.add(newReview![0]);
                            // review.add(newReview![1]);
                            // dates.add(DateFormat.yMMMMd().format(DateTime.now()));
                            // likePressed.add(false);
                            // likes.add(0);
                          },
                          child: const Text('Review Club'))),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
