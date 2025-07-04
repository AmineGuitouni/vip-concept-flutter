import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/reviews/models/reviews_model.dart';
import 'package:localboss/features/reviews/view/widgets/review_item.dart';

class LatestReviews extends StatelessWidget {
  final List<ReviewsModel> latestReviews;
  const LatestReviews({ super.key, required this.latestReviews});

  @override
  Widget build(BuildContext context){
    if(latestReviews.isNotEmpty){
      latestReviews.sort((a, b){
        final c = DateTime.parse(a.updateTime).compareTo(DateTime.parse(b.updateTime));
        return -c;
      });
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: HomeLayout.blueWh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Latest Reviews ",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(children: [
                  ...List.generate(
                      min(latestReviews.length, 3), (index) {
                        ReviewsModel review = latestReviews[index];
                        return Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10),
                            decoration: BoxDecoration(
                              color: HomeLayout.blueWh,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black.withOpacity(0.05),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: 160,
                                    child: SingleChildScrollView(
                                        child: ReviewItem(
                                      review: review,
                                      small: true,
                                    ))),
                                SizedBox(
                                    width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.8 -
                                        95,
                                    child: ReviewItemButtons(
                                      review: review,
                                      small: true,
                                    )),
                              ],
                            ));
                      }),
                  GestureDetector(
                    onTap: () {
                      context.push("/reviews");
                    },
                    child: Container(
                      width: 250,
                      height: 300,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10),
                      decoration: BoxDecoration(
                        color: HomeLayout.blueWh,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(
                            "View all reviews",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}