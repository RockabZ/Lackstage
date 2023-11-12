import 'package:cloud_firestore/cloud_firestore.dart';

class Notify {
  final String text;
  final String postId;
  final String id;
  final String receiverId;
  final String notificationType;
  final Timestamp timestamp;

  Notify(
      {required this.text,
      required this.postId,
      required this.id,
      required this.receiverId,
      required this.notificationType,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'postId': postId,
      'id': id,
      'receiverId': receiverId,
      'notificationType': notificationType,
      'timestamp': timestamp,
    };
  }
}
