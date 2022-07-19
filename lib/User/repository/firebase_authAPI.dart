import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  //final _facebookLogin = FacebookLogin();

  Future<User> signIn() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication? gSA = await googleSignInAccount!.authentication;

    UserCredential auth = await _auth.signInWithCredential(
        (GoogleAuthProvider.credential(
            idToken: gSA.idToken, accessToken: gSA.accessToken)));
    print(auth.user);
    return auth.user!;
  }

  signOut() async {
    await _auth.signOut().then((onValue) => print("Sesión cerrada"));
    googleSignIn.signOut();
    //_facebookLogin.logOut();
    print("Sesiones cerradas correctamente");
  }
}
