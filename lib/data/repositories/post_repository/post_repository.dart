import 'package:digital_notice_board/data/models/all_posts_model.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_provider.dart';
import 'package:flutter/material.dart';

class AllPostsRepository {
  final AllPostsProvider allPostsProvider;

  AllPostsRepository({@required this.allPostsProvider});

  Future<List<AllPostsModel>> getAllPosts() async {
    var responseData = await allPostsProvider.getAllPosts();

    if (responseData == null) {
      return null;
    }
    List<AllPostsModel> posts = [];
    for (var post in responseData) {
      posts.add(AllPostsModel.fromJson(post));
    }

    print(posts);
    return posts;
  }
}
