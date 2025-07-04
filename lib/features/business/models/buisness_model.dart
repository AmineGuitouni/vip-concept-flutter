class BuisnessModel {
  String name; // el id mta3 el business
  String accountId;
  String title; 
  String? websiteUri; // url lel ebsite kan fama
  String? mapUri; // link mta3 el business fi google maps
  String newReviewUri; // link bech el user ya3mel review
  int totalReviewCount;
  double averageRating;
  String businessType;

  BuisnessModel({
    required this.name,
    required this.title,
    this.websiteUri,
    this.mapUri,
    required this.newReviewUri,
    required this.totalReviewCount,
    required this.averageRating, 
    required this.businessType,
    required this.accountId
  });
}