import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:digital_notice_board/data/repositories/like_post_repository/like_post_provider.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_provider.dart';
import 'package:flutter/material.dart';

class LikePostRepository {
  final LikePostProvider likePostProvider;

  LikePostRepository({@required this.likePostProvider});

  Future<bool> likePost(
      {@required String postId, @required String userId}) async {
    var responseData = await likePostProvider.likePost(postId, userId);

    if (responseData == null) {
      return null;
    }

    return responseData;
  }
}
