import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:localboss/core/constants.dart';
import 'package:localboss/features/auth/services/auth_service.dart';

abstract class ReviewsRepo {
  static Future<dynamic> getReviews(String userId, String locationId) async{
    final String? accessToken = await AuthService().getAccessToken();
    if(accessToken == null) {
      return null;
    }

    final Map<String, String> body = {
      'accessToken': accessToken,
      'userId': userId,
      'locationId': locationId
    };

    try{
      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/getReviews'),
        body: body
      );

      return jsonDecode(response.body);
    }catch(e){
      if(kDebugMode) print(e);
    }
  }
}