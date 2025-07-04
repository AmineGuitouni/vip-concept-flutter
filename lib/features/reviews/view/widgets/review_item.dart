import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localboss/core/utils.dart';
import 'package:localboss/features/reviews/models/reviews_model.dart';
import 'package:localboss/features/reviews/view/widgets/review_reply.dart';

class ReviewItem extends StatelessWidget {
  final ReviewsModel review;
  final bool small;
  const ReviewItem({
    super.key,
    required this.review,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width * (small ? 0.7 : 1.0),
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
          backgroundImage: NetworkImage(review.reviewer.profilePhotoUrl),
          //backgroundImage: const AssetImage("lib/assets/back.jpg"),
          backgroundColor: Colors.grey[500],
          onBackgroundImageError: (exception, stackTrace) {
            if(kDebugMode) print('Failed to load image: $exception');
          },
          radius: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              review.reviewer.displayName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Row(children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < review.starRating ? Icons.star : Icons.star_border,
                  color: Colors.blue[900],
                  size: 12,
                );
              }),
              const SizedBox(width: 8),
              Text(
                getTime(review.updateTime),
                style: const TextStyle(fontSize: 12),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7 * (small ? 0.8 : 1.0),
                child: Text(getReviewComment(review))),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6 * (small ? 0.8 : 1.0),
              child: Divider(
                color: Colors.grey[500],
                thickness: 0.5,
                height: 32,
              ),
            ),
            if (review.reply != null && !small)
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL!),
                      //backgroundImage: const AssetImage("lib/assets/back.jpg"),
                      backgroundColor: Colors.grey[500],
                      onBackgroundImageError: (exception, stackTrace) {
                        if(kDebugMode) print('Failed to load image: $exception');
                      },
                      radius: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Text("Replied:"),
                            const SizedBox(width: 8),
                            Text(getTime(review.reply!.updateTime)),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(review.reply != null
                                  ? review.reply!.comment
                                  : "")),
                        ],
                      ),
                    )
                  ]),
            if (review.reply != null && !small)
            const SizedBox(
              height: 10,
            ),
            if(!small) SizedBox(
              width: MediaQuery.of(context).size.width * (small ? 0.8 : 1.0) - 95,
              child: ReviewItemButtons(review: review, small: small,) 
            ),
          ]),
        ),
      ]),
    );
  }

  String getReviewComment(ReviewsModel review){
    List<String> reviewList = review.comment.split("(Original)");

    return reviewList[reviewList.length-1].trim();
  }
}
class ReviewItemButtons extends StatelessWidget {
  final ReviewsModel review;
  final bool small;
  const ReviewItemButtons({super.key , required this.review, required this.small});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            _showBottomSheet(context, review);
          },
          style: ElevatedButton.styleFrom(
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
          child: Text(
            review.reply != null ? "Edit Reply" : "Reply",
            style: TextStyle(
              fontSize: small ? 12 : 16
            ),
          ),
        ),
        // const SizedBox(
        //   width: 10,
        // ),
        // ElevatedButton(
        //   onPressed: () {},
        //   style: ElevatedButton.styleFrom(
        //     shape: const ContinuousRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(16))),
        //   ),
        //   child: Text(
        //     "share",
        //     style: TextStyle(
        //       fontSize: small ? 12 : 16
        //     ),
        //   ),
        // ),
      ],
    );
  }
  void _showBottomSheet(BuildContext context, ReviewsModel content) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return ReviewReply(review: review);
    },
    showDragHandle: true,
    isDismissible: false,
    elevation: 0,
  );
  }
}