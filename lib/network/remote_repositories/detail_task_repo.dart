
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailTaskRepo {
  static Future<List> getComments({required String id}) async {
    List commentsList = [];
    await FirebaseFirestore.instance.collection(id)
        .get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        Map commentsData = doc.data() as Map;
        commentsList.add(commentsData);
      })
    });
    return commentsList;
  }
}

