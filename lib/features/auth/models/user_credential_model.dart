import 'package:cloud_firestore/cloud_firestore.dart';

class UserCredentialModel {
  final String? name;
  final String? email;
  final String? image;

  Timestamp? subscriptionDate;
  int aiCredit;

  UserCredentialModel({
    required this.name,
    required this.email,
    required this.image,
    required this.subscriptionDate,
    required this.aiCredit,
  });
}