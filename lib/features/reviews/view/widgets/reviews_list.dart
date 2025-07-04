import 'package:flutter/material.dart';
import 'package:localboss/features/reviews/models/reviews_model.dart';
import 'package:localboss/features/reviews/view/widgets/review_item.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewsModel> reviews;
  final bool showAll;

  const ReviewsList({
    super.key,
    required this.reviews,
    required this.showAll,
  });

  @override
  Widget build(BuildContext context) {
    List<ReviewsModel> filterdReviews = _getFilterdReviews();
    return filterdReviews.isEmpty
        ? Center(
            child: Text(
              reviews.isEmpty
                  ? "There is no review at the moment"
                  : "No non replied reviews",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        : Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListView.builder(
                itemCount: filterdReviews.length,
                itemBuilder: (context, index) {
                  return ReviewItem(review: filterdReviews[index]);
                }),
          );
  }

  List<ReviewsModel> _getFilterdReviews() {
    if (showAll) {
      reviews.sort((a, b){
        final c = DateTime.parse(a.updateTime).compareTo(DateTime.parse(b.updateTime));
        return -c;
      });
      return reviews;
    }
    List<ReviewsModel> filterdReviews = [];

    reviews.forEach((review) {
      if (review.reply == null) {
        filterdReviews.add(review);
      }
    });

    filterdReviews.sort((a, b){
      final c = DateTime.parse(a.updateTime).compareTo(DateTime.parse(b.updateTime));
      return -c;
    });

    return filterdReviews;
  }
}