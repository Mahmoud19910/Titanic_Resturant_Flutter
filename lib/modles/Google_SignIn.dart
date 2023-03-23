import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInAuth{

  static FirebaseAuth auth = FirebaseAuth.instance;
 static UserCredential? userCredential;

  // تسجيل الدخول بواسطة جيميل
 static Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
     userCredential=await auth.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<void> _handleSignIn({required BuildContext context}) async {
    try {
      await signInWithGoogle();
    } catch (error) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }


  }

  // Sign Out Function
  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }




}