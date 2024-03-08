import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';

String collection = 'englishTeaching';

Future<Map?> getUserInfo(String uid) async {
  Map? data;

  await FirebaseFirestore.instance
      .collection(collection)
      .doc(uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          data = documentSnapshot.data() as Map?;
        } else {
          print("Document doe not exist");
          return null;
        }

  });
  return data;
}

Future<Map?> getMyInfo() async {
  Map? data;
  String uid = AuthenticationHelper().uid;
  data = await getUserInfo(uid);
  return data;
}

Future<bool> editUserInfo(Map<String, dynamic> data) async {
  String uid = AuthenticationHelper().uid;
  FirebaseFirestore.instance
      .collection(collection)
      .doc(uid)
      .set(data, SetOptions(merge: true));
  return true;
}

Future<Map<String, dynamic>> getLessons() async {
  Map<String, dynamic> lessons = {};
  String uid = AuthenticationHelper().uid;
  await getUserInfo(uid).then((data) {
    try{
      lessons = data!['lessons'];
    } catch (_) {
      print("The data does not have event");
    }
  });
  return lessons;
}

Future<bool> addLessons(Map<String, dynamic> data) async {
  String uid = AuthenticationHelper().uid;
  FirebaseFirestore.instance
      .collection(collection)
      .doc(uid)
      .set({'lessons': data}, SetOptions(merge: true));
  return true;
}

Future<bool> updateLesson(Map<String, dynamic> data) async {
  String uid = AuthenticationHelper().uid;
  FirebaseFirestore.instance
      .collection(collection)
      .doc(uid)
      .set({'lessons': data}, SetOptions(merge: true));
  return true;
}