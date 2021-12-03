import 'package:digital_notice_board/blocs/all_posts_bloc/all_post_state.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_event.dart';
import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class AllPostsBloc extends Bloc<AllPostsEvent, AllPostsState> {
  static const LOG_NAME = 'bloc.all_posts';
  final AllPostsRepository allPostsRepository;
  PostsResponse postResponse;
  AllPostsBloc({AllPostsState initialState, @required this.allPostsRepository})
      : super(initialState);
  @override
  Stream<AllPostsState> mapEventToState(
    AllPostsEvent event,
  ) async* {
    if (event is FetchAllPostsEvents) {
      yield AllPostsLoadingState();
    }

    try {
      postResponse = await allPostsRepository.getAllPosts();
      print(postResponse);
      yield AllPostsLoadedState(postsResponse: postResponse);
    } catch (e) {
      dev.log('Error in fetcing posts: $e', name: LOG_NAME);
      yield AllPostsErrorState(message: "Error occurred while fetching posts");
    }
  }
}
