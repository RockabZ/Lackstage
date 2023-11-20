import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Model/notification.dart';
import 'package:http/http.dart' as http;

class NotificationService extends ChangeNotifier {
  //get instance of auth and firestore and firebase messaging
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // get token from user
  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print(' my token is ${token}');
      return token;
    } catch (e) {
      return '';
    }
  }

  // SEND NOTIFICATION
  void sendPushMessage(String token, String title, String text) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAj4c-X-I:APA91bEwXm_rMV5-DeODWOLsS3kNZzUzskvL2AHUXkipu6thnG0C2WQS_t9W91ew7A7GJdlsl2DJ2d1SfJhm8k41bIW3dF6eTsv0maev5D1ob6yhnsvMZVCPRyLk1RX59O4IydDFaAZv'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': text,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": text,
              "android_channel_id": "dbfood"
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('erro');
      }
    }
  }

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
