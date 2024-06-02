import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytennisclub/guest_android_app/guest_search_screen/guest_club_profile/guest_review.dart';
import 'package:mytennisclub/models/guest.dart';
import 'package:mytennisclub/models/tennis_club.dart';

class ClubReview extends StatefulWidget {
  final int guestID;
  final int clubID;
  const ClubReview({required this.clubID, required this.guestID, super.key});

  @override
  State<ClubReview> createState() => _ClubReviewState();
}

class _ClubReviewState extends State<ClubReview> {
  Future<void> _openReview(context) async {
    showModalBottomSheet<List<String>>(
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
    bool canSubmit = true;
    return FutureBuilder<List<dynamic>>(
        future: TennisClub.getClubReviews(widget.clubID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reviews retrieved'));
          } else {
            final clubReviews = snapshot.data!;
            late List<int> likes = List<int>.generate(
                clubReviews.length, (int index) => clubReviews[index][2]);

            for (var row in clubReviews) {
              if (row[1] == widget.guestID) {
                canSubmit = false;
              }
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: clubReviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        key: ObjectKey(
                          clubReviews[index],
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
                                      clubReviews[index][0][0],
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
                                          (clubReviews[index][1] !=
                                                  widget.guestID)
                                              ? clubReviews[index][0]
                                              : 'Your review',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          DateFormat.yMMMMd()
                                              .format(clubReviews[index][5]),
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
                                  clubReviews[index][3].toString(),
                                  style: const TextStyle(
                                    color: Color.fromRGBO(29, 27, 32, 0.7),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    //(likePressed[index] == false)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Guest.addLike(clubReviews[index][1],
                                              widget.clubID);
                                          // likePressed[index] = true;
                                          likes[index]++;
                                        });
                                      },
                                      child: const Icon(
                                          Icons.favorite_border_outlined,
                                          size: 20),
                                    ),
                                    // : GestureDetector(
                                    //     onTap: () {
                                    //       setState(() {
                                    //         Guest.removeLike(
                                    //             clubReviews[index][1],
                                    //             widget.clubID);

                                    //         likePressed[index] = false;
                                    //         likes[index]--;
                                    //       });
                                    //     },
                                    //   child: const Icon(
                                    //     Icons.favorite,
                                    //     size: 20,
                                    //   ),
                                    // ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        child: (canSubmit)
                            ? FilledButton(
                                onPressed: () async {
                                  bool isMember = await Guest.checkMembership(
                                      widget.guestID, widget.clubID);

                                  isMember
                                      ? _openReview(context)
                                      : _showErrorDialog(context,
                                          'You Are Not Allowed To Review This Club');
                                },
                                child: const Text('Review Club'))
                            : const Text(
                                'You Have Already Reviewed This Club')),
                  ),
                ],
              ),
            );
          }
        });
  }
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
