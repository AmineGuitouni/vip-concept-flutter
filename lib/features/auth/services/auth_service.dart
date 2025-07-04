import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localboss/features/auth/viewModels/auth_provider.dart' as app_auth;

class AuthService {
  List<String> scopes = [
    "https://www.googleapis.com/auth/business.manage",
    "https://www.googleapis.com/auth/plus.business.manage"
  ];
  //Google sign in
  signInWithGoogle(app_auth.AuthProvider authProvider) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: scopes).signIn();

    if (googleUser == null) {
      throw Exception('Google sign in aborted by user');
    }

    authProvider.startLoading();

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<String?> getAccessToken() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
    
    if(googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    return googleAuth.accessToken;
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    DocumentReference docRef = await FirebaseFirestore.instance.collection("users").doc(userId);
    DocumentSnapshot docSnapshot = await docRef.get();
    if (!docSnapshot.exists && FirebaseAuth.instance.currentUser != null){
      await docRef.set({
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': FirebaseAuth.instance.currentUser!.displayName
      });
      
      return {
        "aiCredit": 0, "subscriptionDate": null
      };
    }else{
      final userdb = docSnapshot.data() as Map<String, dynamic>;
      return {"aiCredit": userdb["aiCredit"] ?? 0, "subscriptionDate": userdb["subscription"]};
    }
  }
}