import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graceful_shop/controllers/user_controller.dart';

class GoogleSignInProvider extends ChangeNotifier {
  UserController userController = Get.find<UserController>();
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      // print('1');
      final googleUser = await googleSignIn.signIn();
      // print('2');
      if (googleUser == null) return;

      print(googleUser);

      final googleAuthen = await googleUser.authentication;
      //  print('5');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthen.accessToken,
        idToken: googleAuthen.idToken,
      ); 

      print(googleAuthen.accessToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      userController.loginWithGoogle(googleUser);
      
      // print('success: login');
    
    } catch (e) {
    //  Get.log(e.toString());
      Get.log('Login gg fail');
    }
    notifyListeners();
  }

  Future logOut() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}