import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sdp_wits_services/Firebase/firebase_options.dart';
import 'package:sdp_wits_services/Staff/StaffHomePage.dart';
import 'package:sdp_wits_services/app.dart';

import '../StudentsApp/Home/Home.dart';

String btn = "";

class AuthService {
  //handle authentication state
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (FirebaseAuth.instance.currentUser != null) {
            return _verifyEmail();
          } else {
            return const App();
          }
        });
  }

  //handle sign in with google
  signInWithGoogle(String butn, context) async {
    btn = butn;
    String? clientId = '';
    if(Theme.of(context).platform == TargetPlatform.iOS){
      clientId = DefaultFirebaseOptions.currentPlatform.iosClientId;
    }
    else if(Theme.of(context).platform == TargetPlatform.android){
      clientId = DefaultFirebaseOptions.currentPlatform.androidClientId;
    }
    print('the client id here is =============== $clientId');

    try {
      //trigger the authentication flow
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>['email'],
        hostedDomain: "",
        clientId: clientId,
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      //obtain the auth details from the request
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;

      String userEmail = googleUser.email;

      for (int i = 0; i < userEmail.length; i++) {
        if (userEmail[i] == '@') {
          String emailExtension = userEmail.substring(i, userEmail.length);

          if (emailExtension == '@students.wits.ac.za' &&
              btn == 'SignInAsStaff') {
            await googleSignIn.disconnect();
            String msg = 'You Should Sign In As A Student';
            Fluttertoast.showToast(msg: msg, fontSize: 18);
            return const App();
          } else if (emailExtension == '@wits.ac.za' &&
              btn == 'SignInAsStudent') {
            await googleSignIn.disconnect();
            String msg = 'You Should Sign In As A Staff';
            Fluttertoast.showToast(msg: msg, fontSize: 18);
            return const App();
          } else if (emailExtension != '@students.wits.ac.za' &&
              btn == 'SignInAsStudent') {
            await googleSignIn.disconnect();
            String msg = 'Use Your Wits Student Email';
            Fluttertoast.showToast(msg: msg, fontSize: 18);
            return const App();
          } else if (emailExtension != '@wits.ac.za' &&
              btn == 'SignInAsStaff') {
            await googleSignIn.disconnect();
            String msg = 'Use Your Wits Staff Email';
            Fluttertoast.showToast(msg: msg, fontSize: 18);
            return const App();
          } else {
            //create a new credential
            final credential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );

            //once signed in return the user's credential
            return await FirebaseAuth.instance.signInWithCredential(credential);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //check if it is a student signing in
  //or a staff member
  _verifyEmail() {
    String userEmail = FirebaseAuth.instance.currentUser!.email!;

    for (int i = 0; i < userEmail.length; i++) {
      if (userEmail[i] == '@') {
        String emailExtension = userEmail.substring(i, userEmail.length);

        if (emailExtension == '@students.wits.ac.za' &&
            btn == 'SignInAsStudent') {
          return Home();
        } else if (emailExtension == '@wits.ac.za' && btn == 'SignInAsStaff') {
          return const StaffHomePage();
        }
      }
    }
  }
}
