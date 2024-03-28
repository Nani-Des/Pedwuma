import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handyman_app/wrapper.dart';
import 'package:the_apple_sign_in/scope.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

import 'database.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  // signInWithGoogle(BuildContext context) async {
  //   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //   final GoogleSignInAccount? googleSignInAccount =
  //   await googleSignIn.signIn();
  //
  //   final GoogleSignInAuthentication? googleSignInAuthentication =
  //   await googleSignInAccount?.authentication;
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     idToken: googleSignInAuthentication?.idToken,
  //     accessToken: googleSignInAuthentication?.accessToken,
  //   );
  //
  //   UserCredential result =
  //   await firebaseAuth.signInWithCredential(credential);
  //
  //   User? userDetails = result.user;
  //
  //   if (result != null) {
  //     Map<String, dynamic> userInfoMap = {
  //       "Email Address": userDetails!.email,
  //       "First Name": userDetails.displayName,
  //       "Pic": userDetails.photoURL,
  //       "User ID": userDetails.uid,
  //     };
  //     DatabaseMethods().addUser(userDetails.uid, userInfoMap).then((value) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => Wrapper()),
  //       );
  //     });
  //   }
  // }

  Future<User> signInWithApple( BuildContext context,{List<Scope> scopes = const []}) async {
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(AppleIdCredential.identityToken!));
        final UserCredential = await auth.signInWithCredential(credential);
        final firebaseUser = UserCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = AppleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
          Map<String, dynamic> userInfoMap = {
              "Email Address": firebaseUser.email,
              "First Name": fullName?.givenName,
              "Last Name": fullName?.familyName,
              "User ID": firebaseUser.uid,
            };
            DatabaseMethods().addUser(firebaseUser.uid, userInfoMap).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wrapper()),
              );
            });
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
            code: 'ERROR_AUTHORIZATION_DENIED',
            message: result.error.toString());

      case AuthorizationStatus.cancelled:
        throw PlatformException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');

      default:
        throw UnimplementedError();
    }
  }
}
