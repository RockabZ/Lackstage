import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationTile extends StatelessWidget {
  final String id;
  final String notificationType;
  final String postId;
  final String text;
  final Timestamp timestamp;
  const NotificationTile(
      {super.key,
      required this.id,
      required this.notificationType,
      required this.postId,
      required this.text,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    String data = timeago.format(
      timestamp.toDate(),
      locale: 'en_short',
    );
    List<String> hmm = [text, data];
    String notificate = hmm.join(" a ");
    return ListTile(
      leading: notificationType == 'chat'
          ? const Icon(
              Icons.message,
              color: Pallete.whiteColor,
            )
          : notificationType == 'like'
              ? SvgPicture.asset(
                  AssetsConstants.likeFilledIcon,
                  color: Pallete.redColor,
                  height: 20,
                )
              : notificationType == 'comment'
                  ? SvgPicture.asset(
                      AssetsConstants.commentIcon,
                      color: Pallete.whiteColor,
                      height: 20,
                    )
                  : null,
      title: Text(notificate),
    );
  }
}
