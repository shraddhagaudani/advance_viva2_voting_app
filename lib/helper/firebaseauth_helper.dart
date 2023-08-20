import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firestore_helper.dart';

class FireBaseAuthHelper{

  FireBaseAuthHelper._();

 static final  FireBaseAuthHelper fireBaseAuthHelper = FireBaseAuthHelper._();

 static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
static final  GoogleSignIn googleSignIn = GoogleSignIn();

//signinwithgoogle:
  Future<Map<String, dynamic>> signInWithGoogle() async {
    Map<String, dynamic> data = {};
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
      await firebaseAuth.signInWithCredential(credential);

      User? user = userCredential.user;

      data['user'] = user;

      // String? token = await FCMHelper.fcmHelper.getDeviceToken();



      //TODO : add user into firestore database
      FireStoreHelper.fireStoreHelper.insertUserWhileSignIn(data: {
        "email": user!.email,
        "name": user.displayName,
        // "uid": user?.uid,
        // "token": token,
        // "phonenumber": user?.phoneNumber,
      });
      // FireStoreHelper.fireStoreHelper.addUser(data: {
      //     "email": user!.email,
      //     "name": user.displayName,
      // });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          data['msg'] = "This service is temporary down.";
        case "There is no user record corresponding to this identifier":
          data['msg'] = "This user is not available.";
        default:
          data['msg'] = e.code;
      }
    }
    return data;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}