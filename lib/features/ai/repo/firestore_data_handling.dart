import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreDataHandling {
  static Future<void> saveAiSettings(double value1, double value2, bool useEmojis, String responseLength, String customOptions) async {
    if(FirebaseAuth.instance.currentUser == null) return;
    
    final userId = FirebaseAuth.instance.currentUser!.uid;

    try{
      await FirebaseFirestore.instance.collection('aiSettings').doc(userId).set({
        "value1": value1,
        "value2": value2,
        "useEmojis": useEmojis,
        "responseLength": responseLength,
        "costumOptions": customOptions
      });
    }
    catch(e){
      // Todo: show error toast
      print(e);
    }
  }

  static Future<dynamic> getAiSettings() async {
    if(FirebaseAuth.instance.currentUser == null) return;

    final userId = FirebaseAuth.instance.currentUser!.uid;

    try{
      final result = await FirebaseFirestore.instance.collection('aiSettings').doc(userId).get();
      return result.data();
    }
    catch(e){
      // Todo: show error toast
      print(e);
    }
  }
}