import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/hashtag_text.dart';
import 'package:lackstage/ui/Post_Icon_Buttons.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget postCard(String nome, String text, int curtidas, int reposts,
    int comentarios, Timestamp timestamp) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/1816/1816466.png'),
              radius: 35,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //repost
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Text(
                        nome,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                    Text(
                      timeago.format(
                        timestamp.toDate(),
                        locale: 'en_short',
                      ),
                      style: const TextStyle(
                        color: Pallete.greyColor,
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
                //replied to
                HastagText(text: text),

                //if haves images
                Container(
                  margin: EdgeInsets.only(top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PostIconButton(
                          pathname: AssetsConstants.commentIcon,
                          text: comentarios.toString(),
                          onTap: () {}),
                      PostIconButton(
                          pathname: AssetsConstants.repostIcon,
                          text: reposts.toString(),
                          onTap: () {}),
                      PostIconButton(
                          pathname: AssetsConstants.likeOutlinedIcon,
                          text: curtidas.toString(),
                          onTap: () {}),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
              ],
            ),
          )
        ],
      ),
      const Divider(
        color: Pallete.borderColor,
        height: 10,
      )
    ],
  );
}
