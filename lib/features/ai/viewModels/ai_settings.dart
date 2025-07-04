import 'package:flutter/material.dart';
import 'package:localboss/features/ai/repo/firestore_data_handling.dart';

enum ResponseLength { short, medium, long }

class AiSettingsProvider with ChangeNotifier {
  double value1 = 0.5;
  double value2 = 0.5;

  bool useEmojis = false;
  String responseLength = "short";

  String customOptions = "";

  AiSettingsProvider(){
    FirestoreDataHandling.getAiSettings().then((value) {
      if(value != null){
        value1 = value['value1'] ?? 0.5;
        value2 = value['value2'] ?? 0.5;
        useEmojis = value['useEmojis'] ?? false;
        responseLength = value['responseLength'] ?? "short";
        customOptions = value['costumOptions'] ?? "";
        notifyListeners();
      }
    });
  }
  void changeValue1(double value) {
    value1 = value;
    notifyListeners();
  }

  void changeValue2(double value) {
    value2 = value;
    notifyListeners();
  }

  void toggleEmojis(bool value) {
    useEmojis = value;
    notifyListeners();
  }

  void toggleResponseLength(String value) {
    responseLength = value;
    notifyListeners();
  }

  void setCustomOptions(String value) {
    customOptions = value;
    //notifyListeners();
  }

  void saveToDB() {
    FirestoreDataHandling.saveAiSettings(value1, value2, useEmojis, responseLength, customOptions);
  }
}