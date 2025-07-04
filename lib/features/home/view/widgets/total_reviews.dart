import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:provider/provider.dart';

class TotalreviewsContainer extends StatefulWidget {
  const TotalreviewsContainer({super.key});

  @override
  State<TotalreviewsContainer> createState() => _TotalreviewsContainerState();
}

class _TotalreviewsContainerState extends State<TotalreviewsContainer> {
  bool boolTotalReviews = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsData>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: HomeLayout.blueWh),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Total reviews",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                      Ionicons.list_circle_sharp,
                      color: HomeLayout.blueCyan,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: boolTotalReviews
                        ? Icon(CupertinoIcons.arrowtriangle_down_circle_fill,
                            color: HomeLayout.blueCyan, size: 25)
                        : Icon(CupertinoIcons.arrowtriangle_up_circle_fill,
                            color: HomeLayout.blueCyan, size: 25),
                    onPressed: () {
                      setState(() {
                        boolTotalReviews = !boolTotalReviews;
                      });
                    },
                  )
                ],
              ),
              if (boolTotalReviews)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "5",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    TotalReviewRow(
                      numberOfStars: 5,
                      theColor: HomeLayout.fiveStars,
                      totalReviews: value.selectedBusiness != null
                          ? value.nbrFiveStars
                          : 0,
                      percentage: value.selectedBusiness != null &&
                              value.selectedBusiness!.totalReviewCount > 0
                          ? value.nbrFiveStars /
                              value.selectedBusiness!.totalReviewCount
                          : 0,
                    ),
                    TotalReviewRow(
                      numberOfStars: 4,
                      theColor: HomeLayout.fourStars,
                      totalReviews: value.selectedBusiness != null
                          ? value.nbrFourStars
                          : 0,
                      percentage: value.selectedBusiness != null &&
                              value.selectedBusiness!.totalReviewCount > 0
                          ? value.nbrFourStars /
                              value.selectedBusiness!.totalReviewCount
                          : 0,
                    ),
                    TotalReviewRow(
                      numberOfStars: 3,
                      theColor: HomeLayout.threeStars,
                      totalReviews: value.selectedBusiness != null
                          ? value.nbrThreeStars
                          : 0,
                      percentage: value.selectedBusiness != null &&
                              value.selectedBusiness!.totalReviewCount > 0
                          ? value.nbrThreeStars /
                              value.selectedBusiness!.totalReviewCount
                          : 0,
                    ),
                    TotalReviewRow(
                      numberOfStars: 2,
                      theColor: HomeLayout.twoStars,
                      totalReviews: value.selectedBusiness != null
                          ? value.nbrTwoStars
                          : 0,
                      percentage: value.selectedBusiness != null &&
                              value.selectedBusiness!.totalReviewCount > 0
                          ? value.nbrTwoStars /
                              value.selectedBusiness!.totalReviewCount
                          : 0,
                    ),
                    TotalReviewRow(
                      numberOfStars: 1,
                      theColor: HomeLayout.oneStar,
                      totalReviews: value.selectedBusiness != null
                          ? value.nbrOneStars
                          : 0,
                      percentage: value.selectedBusiness != null &&
                              value.selectedBusiness!.totalReviewCount > 0
                          ? value.nbrOneStars /
                              value.selectedBusiness!.totalReviewCount
                          : 0,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class TotalReviewRow extends StatelessWidget {
  const TotalReviewRow(
      {super.key,
      required this.numberOfStars,
      required this.theColor,
      required this.totalReviews,
      required this.percentage});

  final int numberOfStars;
  final Color theColor;
  final int totalReviews;
  final double percentage; // bin el 1 wel 0

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          numberOfStars.toString(),
          style: TextStyle(
              fontSize: 20, color: theColor, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 5,
        ),
        Icon(Icons.star, size: 20, color: theColor),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("Non"),
                )
              ],
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 100) * percentage,
              height: 20,
              decoration: BoxDecoration(
                  color: theColor, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    totalReviews.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }
}