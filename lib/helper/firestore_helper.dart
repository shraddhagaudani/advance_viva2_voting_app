import 'package:advance_viva2_voting_app/helper/firebaseauth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  insertUserWhileSignIn({required Map<String, dynamic> data}) {
    firebaseFirestore
        .collection("user")
        .doc(FireBaseAuthHelper.firebaseAuth.currentUser!.uid)
        .set(data);
  }

  Future voteValueTrueOrFalse() async {
    await firebaseFirestore
        .collection("user")
        .doc(FireBaseAuthHelper.firebaseAuth.currentUser!.uid)
        .update({
      "vote": true,
    });
    Get.snackbar(
      "THANK YOU",
      "YOUR VOTE IS ACCEPTABLE",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
  }

  Future voteForBjp() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
    await firebaseFirestore.collection("politicianparty").doc("1").get();

    Map<String, dynamic>? res = documentSnapshot.data();

    int BJP = (res == null) ? 0 : res['bjp'];

    firebaseFirestore
        .collection("politicianparty")
        .doc("1")
        .update({"bjp": ++BJP});

    //TODO: IF vote given or not by voter person
  }
    Future voteForCongress() async {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firebaseFirestore.collection("politicianparty").doc("1").get();

      Map<String, dynamic>? res = documentSnapshot.data();

      int CONGRESS = (res == null) ? 0 : res['congress'];

      firebaseFirestore.collection("politicianparty").doc("1").update({
        "congress": ++CONGRESS,
      });
    }

    Future voteForAap() async {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firebaseFirestore.collection("politicianparty").doc("1").get();

      Map<String, dynamic>? res = documentSnapshot.data();

      int AAP = (res == null) ? 0 : res['aap'];

      firebaseFirestore
          .collection("politicianparty")
          .doc("1")
          .update({"aap": ++AAP});
    }

    Future voteForOthers() async {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firebaseFirestore.collection("politicianparty").doc("1").get();

      Map<String, dynamic>? res = documentSnapshot.data();

      int OTHERS = (res == null) ? 0 : res['others'];

      firebaseFirestore
          .collection("politicianparty")
          .doc("1")
          .update({"others": ++OTHERS});
    }

    Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
      return firebaseFirestore.collection("politicianparty").snapshots();
    }

// Future insertUserWhileSignIn({required Map<String, dynamic> data}) async {
//   // DocumentReference documentReference =
//   //     await db.collection("users").add(data);
//   //
//   // String docId = documentReference.id;
//   // print("============");
//   // print(docId);
//   // print("============");
//
//   DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//       await firebaseFirestore.collection("records").doc("users").get();
//
//   Map<String, dynamic> res = documentSnapshot.data() as Map<String, dynamic>;
//
//   int id = res['id'];
//   int length = res['length'];
//   // String tokenid = res['tokenid'];
//
//   print(id);
//   print(length);
//   // print(tokenid);
//
//   await firebaseFirestore.collection("users").doc("${++id}").set(data);
//
//   await firebaseFirestore.collection("records").doc("users").update({
//     "id": id, "length": ++length,
//     // "tokenid": "tokenid"
//   });
// }

// Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
//   return firebaseFirestore.collection("users").snapshots();
  }

