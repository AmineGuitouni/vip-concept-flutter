import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:localboss/features/auth/services/auth_service.dart';
import 'package:localboss/features/business/models/buisness_model.dart';
import 'package:localboss/features/reviews/models/reviews_model.dart';
import 'package:localboss/features/reviews/repo/reviews_repo.dart';

class ReviewsData with ChangeNotifier {
  List<ReviewsModel> reviews = [];
  bool isLoading = false;

  int nbrFiveStars = 0;
  int nbrFourStars = 0;
  int nbrThreeStars = 0;
  int nbrTwoStars = 0;
  int nbrOneStars = 0;

  BuisnessModel? selectedBusiness;

  Future<void> loadReviews(BuisnessModel business) async {
    selectedBusiness = business;
    reviews = [];
    nbrFiveStars = 0;
    nbrFourStars = 0;
    nbrThreeStars = 0;
    nbrTwoStars = 0;
    nbrOneStars = 0;

    if(FirebaseAuth.instance.currentUser == null || FirebaseAuth.instance.currentUser!.providerData.isEmpty){
      return;
    }
    
    isLoading = true;
    notifyListeners();

    try {
      final String? accessToken = await AuthService().getAccessToken();
      if(accessToken == null){
        return;
      }

      final reviewData = await ReviewsRepo.getReviews(business.accountId, business.name);
      
      if(reviewData['reviews'] != null){
        for(int j = 0; j < reviewData['reviews'].length; j++){
          ReviewerModel reviewer = ReviewerModel(
            displayName: reviewData['reviews'][j]['reviewer']['displayName'] ?? "Anonymous",
            profilePhotoUrl: reviewData['reviews'][j]['reviewer']['profilePhotoUrl'] ?? "",
            isAnonymous: false
          );

          int starRating = 0;

          switch(reviewData['reviews'][j]['starRating']){
            case "STAR_RATING_UNSPECIFIED": starRating = 0; break;
            case "ONE": starRating = 1; nbrOneStars++; break;
            case "TWO": starRating = 2; nbrTwoStars++; break;
            case "THREE": starRating = 3; nbrThreeStars++; break;
            case "FOUR": starRating = 4; nbrFourStars++; break;
            case "FIVE": starRating = 5; nbrFiveStars++; break;
          }

          ReplyModel? reply = reviewData['reviews'][j]['reviewReply'] != null ? ReplyModel(
            comment: reviewData['reviews'][j]['reviewReply']['comment'] ?? '', 
            updateTime: reviewData['reviews'][j]['reviewReply']['updateTime'] ?? ""
          ) : null;
          
          ReviewsModel review = ReviewsModel(
            reviewer: reviewer,
            comment: reviewData['reviews'][j]['comment'] ?? "",
            reviewId: reviewData['reviews'][j]['reviewId'] ?? "",
            name: reviewData['reviews'][j]['name'] ?? "",
            createTime: reviewData['reviews'][j]['createTime'] ?? "",
            updateTime: reviewData['reviews'][j]['updateTime'] ?? "",
            starRating: starRating,
            reply: reply,
            nbrFiveStars: nbrFiveStars,
            nbrFourStars: nbrFourStars,
            nbrThreeStars: nbrThreeStars,
            nbrTwoStars: nbrTwoStars,
            nbrOneStars: nbrOneStars
          );

          reviews.add(review);
        }
      }
      
      isLoading = false;
      notifyListeners();
    }
    catch (e) {
      isLoading = false;
      notifyListeners();
      if(kDebugMode) print(e);
    }
  }

  void addReply(ReviewsModel review, ReplyModel? reply) {
    if(reply == null) return;

    reviews.forEach((r){
      if(r.reviewId == review.reviewId){
        r.reply = reply;
        notifyListeners();
      }
    });
  }

  void deleteReply(ReviewsModel review) {
    reviews.forEach((r){
      if(r.reviewId == review.reviewId){
        r.reply = null;
        notifyListeners();
      }
    });
  }

  void reset(){
    reviews = [];
    nbrFiveStars = 0;
    nbrFourStars = 0;
    nbrThreeStars = 0;
    nbrTwoStars = 0;
    nbrOneStars = 0;
    selectedBusiness = null;
    notifyListeners();
  }
}