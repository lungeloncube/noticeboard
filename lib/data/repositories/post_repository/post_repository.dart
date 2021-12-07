import 'package:digital_notice_board/data/models/individual_post_response.dart';
import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_provider.dart';
import 'package:flutter/material.dart';

class AllPostsRepository {
  final AllPostsProvider allPostsProvider;

  AllPostsRepository({@required this.allPostsProvider});

  Future<PostsResponse> getAllPosts() async {
    var responseData = await allPostsProvider.getAllPosts();

    if (responseData == null) {
      return null;
    }

    return PostsResponse.fromJson(responseData);
  }

  Future<IndividualPostResponse> getPostById(
      {@required postId, @required branchId}) async {
    var responseData =
        await allPostsProvider.getPostById(branchId: branchId, postId: postId);

    if (responseData == null) {
      return null;
    }

    return IndividualPostResponse.fromJson(responseData);
  }
}
