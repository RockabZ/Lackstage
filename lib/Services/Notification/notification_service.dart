import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Model/notification.dart';

class NotificationService extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //CREATE NOTIFICATION
  Future<void> createNotification(String receiverId, String postId,
      String notificationType, String text) async {
    //get user current info
    final String id = _firebaseAuth.currentUser!.displayName.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new notification
    Notify newNotification = Notify(
        text: text,
        postId: postId,
        id: id,
        receiverId: receiverId,
        notificationType: notificationType,
        timestamp: timestamp);

    //add new notification to database
    await _firestore
        .collection('notifications')
        .doc(receiverId)
        .collection('default')
        .add(newNotification.toMap());
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getNotifications(String id) {
    return _firestore
        .collection('notifications')
        .doc(id)
        .collection('default')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<bool> checkIfNotifyExists(String receiverId, String postId) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('notifications')
        .doc(receiverId)
        .collection('default')
        .where('postId', isEqualTo: postId)
        .get();
    return (querySnapshot.docs.isEmpty);
  }
}
