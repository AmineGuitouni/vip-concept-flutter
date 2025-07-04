import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localboss/features/auth/models/user_credential_model.dart';
import 'package:localboss/features/auth/services/auth_service.dart';
import 'package:localboss/features/auth/viewModels/auth_provider.dart';

class UserCredentialsProvider extends ChangeNotifier {
  final AuthProvider? authProvider;
  UserCredentialModel? user;

  UserCredentialsProvider(this.authProvider) {
    if(authProvider != null && authProvider!.user != null){
      AuthService.getUserData().then((userData){
        user = UserCredentialModel(
          aiCredit: userData["aiCredit"], 
          subscriptionDate: userData["subscriptionDate"], 
          email: authProvider!.user!.email,
          image: authProvider!.user!.photoURL,
          name: authProvider!.user!.displayName
        );

        notifyListeners();
      });
    }
  }

  void addAiCredits(int credit){
    if(user != null){
      user!.aiCredit += credit;
      notifyListeners();
    }
  }

  void updateSubscriptionDate(Timestamp date){
    if(user != null){
      user!.subscriptionDate = date;
      notifyListeners();
    }
  }
}