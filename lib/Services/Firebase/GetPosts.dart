import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetPosts {
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postsStream;
  }

  Future<void> likePost(String id) async {
    await posts.doc(id).get().then((doc) async {
      final List<dynamic> curtidas =
          (doc.data() as Map<String, dynamic>)['Curtidas'];
      if (curtidas.contains(user!.displayName)) {
        await posts.doc(id).update({
          'Curtidas': FieldValue.arrayRemove([user!.displayName])
        });
      } else {
        await posts.doc(id).update({
          'Curtidas': FieldValue.arrayUnion([user!.displayName])
        });
      }
      return curtidas;
    });
  }
}
