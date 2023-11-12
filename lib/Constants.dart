import 'package:flutter/material.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/ui/chat_function.dart';
import 'package:lackstage/ui/explore_view.dart';
import 'package:lackstage/ui/post_list.dart';

var myAppBar = AppBar(
  backgroundColor: Pallete.backgroundColor,
  centerTitle: true,
  title: const Text('Tela inicial'),
);

class AssetsConstants {
  static const String _svgsPath = 'assets/svgs';
  static const String commentIcon = '$_svgsPath/comment.svg';
  static const String repostIcon = '$_svgsPath/repost.svg';
  static const String likeOutlinedIcon = '$_svgsPath/like_outlined.svg';
  static const String likeFilledIcon = '$_svgsPath/like_filled.svg';

  static List<Widget> bottomTabBarPages = [
    const PostList(),
    const ExploreView(),
    const Text('Notification Screen'),
    const ChatList(),
  ];
}
