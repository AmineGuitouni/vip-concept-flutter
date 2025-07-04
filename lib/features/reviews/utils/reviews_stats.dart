import 'package:localboss/features/reviews/models/reviews_model.dart';

class ReviewsStats {
  static Map<String, List<ReviewsModel>> daylyReviews = {};

  static Map<DateTime, List<ReviewsModel>> groupReviewsByDay(List<ReviewsModel> reviews) {
    Map<DateTime, List<ReviewsModel>> groupedReviews = {};

    for (var review in reviews) {
      DateTime reviewDate = DateTime.parse(review.createTime);
      DateTime day = DateTime(reviewDate.year, reviewDate.month, reviewDate.day);
      
      if (!groupedReviews.containsKey(day)) {
        groupedReviews[day] = [];
      }

      groupedReviews[day]!.add(review);
    }

    return groupedReviews;
  }

  static Map<DateTime, List<ReviewsModel>> groupReviewsByMonth(List<ReviewsModel> reviews) {
    Map<DateTime, List<ReviewsModel>> groupedReviews = {};

    for (var review in reviews) {
      DateTime reviewDate = DateTime.parse(review.createTime);
      DateTime month = DateTime(reviewDate.year, reviewDate.month);

      if (!groupedReviews.containsKey(month)) {
        groupedReviews[month] = [];
      }

      groupedReviews[month]!.add(review);
    }

    return groupedReviews;
  }

  static Map<DateTime, List<ReviewsModel>> groupReviewsByYear(List<ReviewsModel> reviews) {
    Map<DateTime, List<ReviewsModel>> groupedReviews = {};

    for (var review in reviews) {
      DateTime reviewDate = DateTime.parse(review.createTime);
      DateTime month = DateTime(reviewDate.year);

      if (!groupedReviews.containsKey(month)) {
        groupedReviews[month] = [];
      }

      groupedReviews[month]!.add(review);
    }

    return groupedReviews;
  }

  static Map<DateTime, List<ReviewsModel>> groupReviewsByWeek(List<ReviewsModel> reviews) {
    Map<DateTime, List<ReviewsModel>> groupedReviews = {};

    for (var review in reviews) {
      DateTime reviewDate = DateTime.parse(review.createTime);
      reviewDate = DateTime(reviewDate.year, reviewDate.month, reviewDate.day);
      DateTime startOfWeek = reviewDate.subtract(Duration(days: reviewDate.weekday % 7));

      if (!groupedReviews.containsKey(startOfWeek)) {
        groupedReviews[startOfWeek] = [];
      }

      groupedReviews[startOfWeek]!.add(review);
    }

    return groupedReviews;
  }

  static Map<DateTime, double> weaklyAvregeRating(List<ReviewsModel> reviews) {
    final Map<DateTime, List<ReviewsModel>> groupedReviews = groupReviewsByWeek(reviews);

    Map<DateTime, double> weaklyAvregeRating = {};
    groupedReviews.forEach((date, reviews) {
      int sum = 0;
      for (var review in reviews) {
        sum += review.starRating;
      }
      weaklyAvregeRating[date] = (sum / reviews.length * 100).toInt() / 100;
    });

    return weaklyAvregeRating;
  }

  static Map<DateTime, double> monthlyAvregeRating(List<ReviewsModel> reviews) {
    final Map<DateTime, List<ReviewsModel>> groupedReviews = groupReviewsByMonth(reviews);

    Map<DateTime, double> monthlyAvregeRating = {};
    groupedReviews.forEach((date, reviews) {
      int sum = 0;
      for (var review in reviews) {
        sum += review.starRating;
      }
      monthlyAvregeRating[date] = (sum / reviews.length * 100).toInt() / 100;
    });

    return monthlyAvregeRating;
  }

  static Map<DateTime, double> yearlyAvregeRating(List<ReviewsModel> reviews) {
    final Map<DateTime, List<ReviewsModel>> groupedReviews = groupReviewsByYear(reviews);

    Map<DateTime, double> yearlyAvregeRating = {};
    groupedReviews.forEach((date, reviews) {
      int sum = 0;
      for (var review in reviews) {
        sum += review.starRating;
      }
      yearlyAvregeRating[date] = (sum / reviews.length * 100).toInt() / 100;
    });

    return yearlyAvregeRating;
  }

  static Map<DateTime, double> realRatingTrendPerDay(List<ReviewsModel> reviews) {
    final Map<DateTime, double> realRatingPerDay = {};
    if(reviews.isEmpty) return realRatingPerDay;

    reviews.sort((a, b) => DateTime.parse(a.createTime).compareTo(DateTime.parse(b.createTime)));

    DateTime startDate = DateTime.parse(reviews[0].createTime);
    startDate = DateTime(startDate.year, startDate.month, startDate.day);

    DateTime endDate = DateTime.parse(reviews[reviews.length - 1].createTime);
    endDate = DateTime(endDate.year, endDate.month, endDate.day);
    endDate = endDate.add(const Duration(days: 1));

    while (startDate.isBefore(endDate)) {
      double sum = 0;
      double count = 0;

      for (var review in reviews) {
        DateTime reviewDate = DateTime.parse(review.createTime);
        reviewDate = DateTime(reviewDate.year, reviewDate.month, reviewDate.day);

        if(reviewDate.compareTo(startDate) <= 0){
          sum += review.starRating;
          count++;
        }
      }
      
      realRatingPerDay[startDate] = (sum / count * 100).toInt() / 100;
      startDate = startDate.add(const Duration(days: 1));
    }

    return realRatingPerDay;
  }

  static Map<DateTime, double> realRatingTrendPerMonth(List<ReviewsModel> reviews) {
    final Map<DateTime, double> realRatingPerMonth = {};
    if(reviews.isEmpty) return realRatingPerMonth;

    reviews.sort((a, b) => DateTime.parse(a.createTime).compareTo(DateTime.parse(b.createTime)));

    DateTime startDate = DateTime.parse(reviews[0].createTime);
    startDate = DateTime(startDate.year, startDate.month);

    DateTime endDate = DateTime.parse(reviews[reviews.length - 1].createTime);
    endDate = DateTime(endDate.year, endDate.month);
    endDate = DateTime(endDate.year, endDate.month + 1);

    while (startDate.isBefore(endDate)) {
      double sum = 0;
      double count = 0;

      for (var review in reviews) {
        DateTime reviewDate = DateTime.parse(review.createTime);
        reviewDate = DateTime(reviewDate.year, reviewDate.month);

        if(reviewDate.compareTo(startDate) <= 0){
          sum += review.starRating;
          count++;
        }
      }
      
      realRatingPerMonth[startDate] = (sum / count * 100).toInt() / 100;
      startDate = DateTime(startDate.year, startDate.month + 1);
    }

    return realRatingPerMonth;
  }

  static Map<DateTime, double> realRatingTrendPerYear(List<ReviewsModel> reviews) {
    final Map<DateTime, double> realRatingPerYear = {};
    if(reviews.isEmpty) return realRatingPerYear;

    reviews.sort((a, b) => DateTime.parse(a.createTime).compareTo(DateTime.parse(b.createTime)));

    DateTime startDate = DateTime.parse(reviews[0].createTime);
    startDate = DateTime(startDate.year);

    DateTime endDate = DateTime.parse(reviews[reviews.length - 1].createTime);
    endDate = DateTime(endDate.year);
    endDate = DateTime(endDate.year + 1);

    while (startDate.isBefore(endDate)) {
      double sum = 0;
      double count = 0;

      for (var review in reviews) {
        DateTime reviewDate = DateTime.parse(review.createTime);
        reviewDate = DateTime(reviewDate.year);

        if(reviewDate.compareTo(startDate) <= 0){
          sum += review.starRating;
          count++;
        }
      }
      
      realRatingPerYear[startDate] = (sum / count * 100).toInt() / 100;
      startDate = DateTime(startDate.year + 1);
    }

    return realRatingPerYear;
  }

  static Map<DateTime, List<int>> monthlyReviews(List<ReviewsModel> reviews) {
    final reviewGroup = groupReviewsByMonth(reviews);
    final Map<DateTime, List<int>> monthlyCounts = {};

    reviewGroup.forEach((key, reviews) {
      List<int> rateListCount = [0,0,0,0,0];
      for(var review in reviews){
        rateListCount[review.starRating - 1]++;
      }
      monthlyCounts[key] = rateListCount;
    });

    return monthlyCounts;
  }
}