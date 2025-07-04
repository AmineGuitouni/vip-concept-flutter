import 'package:flutter/foundation.dart';
import 'package:localboss/features/business/models/buisness_model.dart';
import 'package:localboss/features/business/repo/business_repo.dart';

class BusinessData with ChangeNotifier {
  List<BuisnessModel> business = [];

  Future<BuisnessModel?> loadBuisnessList() async {
    business = [];

    try {
      final businessData = await BusinessRepo.getBuisnessList();
      if(businessData.isEmpty){
        return null;
      }

      for(int k = 0; k < businessData.length; k++){
        if(businessData[k]['locations'] == null){
          continue;
        }
        for(int i = 0; i < businessData[k]['locations'].length; i++){
          business.add(BuisnessModel(
            name: businessData[k]['locations'][i]['name'],
            title: businessData[k]['locations'][i]['title'] ?? "no title",
            newReviewUri: businessData[k]['locations'][i]['metadata']['newReviewUri'] ?? "",
            websiteUri: businessData[k]['locations'][i]['websiteUri'] ?? "",
            mapUri: businessData[k]['locations'][i]['metadata']['mapUri'] ?? "",
            averageRating: businessData[k]['locations'][i]['averageRating'] ?? 0,
            totalReviewCount: businessData[k]['locations'][i]['totalReviewCount'] ?? 0,
            businessType: businessData[k]['locations'][i]["categories"]["primaryCategory"]["displayName"] ?? "no type",
            accountId: businessData[k]['name']
          ));
        }
      }

      notifyListeners();

      return business.isNotEmpty ? business[0] : null;
    }
    catch (e) {
      if(kDebugMode) print(e);
      return null;
    }
  }
}