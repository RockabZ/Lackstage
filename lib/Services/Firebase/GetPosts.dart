import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lackstage/Services/Notification/notification_service.dart';

class GetPosts {
  User? user = FirebaseAuth.instance.currentUser;
  NotificationService notificationService = NotificationService();
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

  Stream<QuerySnapshot> getPostsUser(String nome) {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .where('Autor', isEqualTo: nome)
        .snapshots();
    return postsStream;
  }

  Stream<QuerySnapshot> getRepliesPostsStream(String id) {
    final postsRepliesStream = FirebaseFirestore.instance
        .collection('Posts')
        .where('RepliedTo', isEqualTo: id)
        .snapshots();

    return postsRepliesStream;
  }

  Stream<QuerySnapshot> getPerfilsBySearch(String nome) {
    final perfilsSearchStram = FirebaseFirestore.instance
        .collection('Users')
        .where('NomeUsuario', isGreaterThanOrEqualTo: nome)
        .where('NomeUsuario', isLessThan: nome + '\uf8ff')
        .snapshots();

    return perfilsSearchStram;
  }

  Future getPerfil(String email) {
    final perfil =
        FirebaseFirestore.instance.collection('Users').doc(email).get();

    return perfil;
  }

  Future<String> getBioByPerfil(String email) async {
    var document =
        await FirebaseFirestore.instance.collection('Users').doc(email).get();
    var bio = document.get('Bio');
    return bio;
  }

  Future<void> likePost(String id, String autor) async {
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
        if (await notificationService.checkIfNotifyExists(autor, id)) {
          notificationService.createNotification(
              autor, id, 'like', '${user!.displayName} curtiu o seu post');
        }
      }
      return curtidas;
    });
  }
}
