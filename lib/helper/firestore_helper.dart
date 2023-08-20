import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future insertUserWhileSignIn({required Map<String, dynamic> data}) async {
    // DocumentReference documentReference =
    //     await db.collection("users").add(data);
    //
    // String docId = documentReference.id;
    // print("============");
    // print(docId);
    // print("============");

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseFirestore.collection("records").doc("users").get();

    Map<String, dynamic> res = documentSnapshot.data() as Map<String, dynamic>;

    int id = res['id'];
    int length = res['length'];
    // String tokenid = res['tokenid'];

    print(id);
    print(length);
    // print(tokenid);

    await firebaseFirestore.collection("users").doc("${++id}").set(data);

    await firebaseFirestore.collection("records").doc("users").update({
      "id": id, "length": ++length,
      // "tokenid": "tokenid"
    });
  }

  // Future addUser({required Map<String, dynamic> data}) async {
  //   DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
  //       await firebaseFirestore.collection("records").doc("users").get();
  //
  //   Map<String, dynamic>? fetchedData = documentSnapshot.data();
  //
  //   int Id = (fetchedData == null) ? 0 : fetchedData['id'];
  //   int Length = (fetchedData == null) ? 0 : fetchedData['length'];
  //
  //   //TODO: check a user already exists or not
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await firebaseFirestore.collection("users").get();
  //
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
  //       querySnapshot.docs;
  //   await firebaseFirestore.collection("users").doc("${++Id}").set(data);
  //
  //   await firebaseFirestore
  //       .collection("records")
  //       .doc("users")
  //       .update({"id": Id, "length": ++Length});
  //
  //   bool isCanVote = false;
  //   isCanVote = (data['age'] >= 18)['age'];
  //
  //   for (QueryDocumentSnapshot<Map<String, dynamic>> element in allDocs) {
  //     if (isCanVote == element.data()['age']) {
  //       isCanVote = true;
  //
  //       break;
  //     } else {
  //       isCanVote = false;
  //       break;
  //     }
  //   }
  //   if (isCanVote == false) {
  //     await firebaseFirestore.collection("users").doc("${++Id}").set(data);
  //
  //     await firebaseFirestore
  //         .collection("records")
  //         .doc("users")
  //         .update({"id": Id, "length": ++Length});
  //   }
  //   Get.showSnackbar(
  //     GetSnackBar(message: "Not Successfully...",
  //       title: "Your Can not vote ",
  //     ),
  //   );
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
    return firebaseFirestore.collection("users").snapshots();
  }
}
