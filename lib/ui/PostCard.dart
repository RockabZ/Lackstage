import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pages/Posts/ReplyScreen.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';
import 'package:lackstage/Services/hashtag_text.dart';
import 'package:lackstage/ui/Post_Icon_Buttons.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget postCard(
  String id,
  String nome,
  String text,
  List<dynamic> curtidas,
  int reposts,
  int comentarios,
  Timestamp timestamp,
  BuildContext context,
  String repliedto,
  String autorreply,
  String aimage,
) {
  User? user = FirebaseAuth.instance.currentUser;

  final GetPosts database = GetPosts();

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReplyScreen(
              comentarios: comentarios,
              curtidas: curtidas,
              id: id,
              nome: nome,
              reposts: reposts,
              text: text,
              timestamp: timestamp,
              repliedto: repliedto,
              autorReply: autorreply,
              aimage: aimage,
            ),
          ));
    },
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: NetworkImage(aimage),
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
                  if (repliedto.isNotEmpty)
                    RichText(
                      text: TextSpan(
                          text: 'Resposta a',
                          style: const TextStyle(
                            color: Pallete.borderColor,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                                text: ' $autorreply',
                                style: const TextStyle(
                                  color: Pallete.blueColor,
                                  fontSize: 16,
                                ))
                          ]),
                    ),
                  HastagText(text: text),

                  //if haves images
                  Container(
                    margin: const EdgeInsets.only(top: 10, right: 20),
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
                        LikeButton(
                          onTap: (isLiked) async {
                            database.likePost(id);
                            return !isLiked;
                          },
                          size: 25,
                          isLiked: curtidas.contains(user!.displayName),
                          likeCount: curtidas.length,
                          likeBuilder: ((isLiked) {
                            return isLiked
                                ? SvgPicture.asset(
                                    AssetsConstants.likeFilledIcon,
                                    // ignore: deprecated_member_use
                                    color: Pallete.gradient2,
                                  )
                                : SvgPicture.asset(
                                    AssetsConstants.likeOutlinedIcon,
                                    // ignore: deprecated_member_use
                                    color: Pallete.borderColor,
                                  );
                          }),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share_outlined,
                            size: 25,
                            color: Pallete.borderColor,
                          ),
                        )
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
    ),
  );
}
