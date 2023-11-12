import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Notification/notification_service.dart';
import 'package:lackstage/ui/notification_tile.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationService notificationService = NotificationService();
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        centerTitle: true,
        title: const Text('Notificações'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: notificationService
                .getNotifications(user!.displayName.toString()),
            builder: (context, snapshot) {
              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              //get all notifications
              final notifications = snapshot.data!.docs;
              //no data
              if (snapshot.data == null || notifications.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text('Você ainda não tem nenhuma notificação'),
                  ),
                );
              }

              // return as a list
              return Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    // get individual post
                    final notification = notifications[index];

                    // get data from each post
                    String id = notification['id'];
                    String text = notification['text'];
                    String notificationType = notification['notificationType'];
                    String postId = notification['postId'];
                    Timestamp timestamp = notification['timestamp'];
                    // return as a list tile

                    return NotificationTile(
                        id: id,
                        notificationType: notificationType,
                        postId: postId,
                        text: text,
                        timestamp: timestamp);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
