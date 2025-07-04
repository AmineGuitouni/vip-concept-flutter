class ReviewsModel {
  String reviewId;
  ReviewerModel reviewer;
  int starRating;
  String comment;

  String createTime;
  String updateTime;

  String name;

  ReplyModel? reply;

  int nbrFiveStars;
  int nbrFourStars;
  int nbrThreeStars;
  int nbrTwoStars;
  int nbrOneStars;

  ReviewsModel({
    required this.reviewId, 
    required this.reviewer, 
    required this.starRating, 
    required this.comment, 
    required this.createTime, 
    required this.updateTime, 
    required this.name,
    required this.nbrFiveStars,
    required this.nbrFourStars,
    required this.nbrThreeStars,
    required this.nbrTwoStars,
    required this.nbrOneStars,
    this.reply
  });
}

class ReviewerModel{
  String profilePhotoUrl;// tasirtou
  String displayName;
  bool isAnonymous;

  ReviewerModel({required this.profilePhotoUrl, required this.displayName, required this.isAnonymous});
}

class ReplyModel {
  String comment;
  String updateTime;

  ReplyModel({required this.comment, required this.updateTime}); 
}