import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:localboss/core/constants.dart';

class Payment {
  static createPaymentIntent() async {
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/api/payment/create')
      );
      
      return jsonDecode(response.body);
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }

  static confirmPayment(String paymentIntentId) async {
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/api/payment/finish'),
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
  
  static Future<bool> makePayment(BuildContext context) async {
    try {
      final paymentIntentData = await createPaymentIntent() ?? {};

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
        return await displayPaymentSheet(context,paymentIntentId);
      });
    } catch (e) {
      if(kDebugMode) print(e);
      return false;
    }
  }

  static Future<bool> displayPaymentSheet(BuildContext context, String paymentIntentId) async {
    try{
      return await Stripe.instance.presentPaymentSheet().then((value) async {

        await confirmPayment(paymentIntentId).then((_){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
        });
        
        return true;
      }).onError((error, stackTrace) {
        return false;
      });
    }on StripeException catch(e){
      if(kDebugMode) print(e);
      return false;
    }
  }
}