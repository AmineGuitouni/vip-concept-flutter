import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:localboss/core/constants.dart';

class AiCreditsPayment {
  static createAiPaymentIntent(int aiPoints) async {
    try {
      final body = {
        "aiPoints":aiPoints.toString()
      };

      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/ai/payment/create'),
        body: body
      );
      if(kDebugMode) print(response.body);
      return jsonDecode(response.body);
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }

  static Future<bool> makeAiPayment(BuildContext context, int aiPoints) async {
    try {
      final paymentIntentData = await createAiPaymentIntent(aiPoints) ?? {};
      
      final paymentIntentClientSecret = paymentIntentData['clientSecret'];
      final paymentIntentId = paymentIntentData['paymentIntentId'];

      if(paymentIntentClientSecret == null || paymentIntentId == null || paymentIntentClientSecret == "" || paymentIntentId == "") return false;
 
      return await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          style: ThemeMode.light,
          customFlow: false,
          merchantDisplayName: "vip-concept",
        )
      ).then((value) async {
        return await displayAiPaymentSheet(context,paymentIntentId);
      });
    } catch (e) {
      if(kDebugMode) print(e);
      return false;
    }
  }

  static Future<bool> displayAiPaymentSheet(BuildContext context, String paymentIntentId) async {
    try{
      return await Stripe.instance.presentPaymentSheet().then((value) async {

        await confirmAiPayment(paymentIntentId).then((_){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
        });

        return true;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    }on StripeException catch(e){
      if(kDebugMode) print(e);
      return false;
    }
  }

  static confirmAiPayment(String paymentIntentId) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/ai/payment/finish'),
        body: {
          "paymentIntentId":paymentIntentId,
          'userId':FirebaseAuth.instance.currentUser!.uid
        }
      );
      if(kDebugMode) print(response);
      return jsonDecode(response.body);
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }
}