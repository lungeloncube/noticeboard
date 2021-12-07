import 'package:digital_notice_board/blocs/like_post_bloc/like_post_event.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_state.dart';
import 'package:digital_notice_board/data/repositories/like_post_repository/like_post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  static const LOG_NAME = 'bloc.like_posts';
  final LikePostRepository likePostRepository;
  bool isLiked = false;

  LikePostBloc({LikePostState initialState, @required this.likePostRepository})
      : super(initialState);
  @override
  Stream<LikePostState> mapEventToState(
    LikePostEvent event,
  ) async* {
    if (event is LikeEvent) {
      yield LikePostLoadingState();

      try {
        final userId = event.userId.replaceAll('.0', '');
        isLiked = await likePostRepository.likePost(
            postId: event.postId, userId: userId);
        print(isLiked);
        yield LikePostLoadedState(liked: isLiked);
      } catch (e) {
        yield LikePostErrorState(response: false);
      }
    }

    if (event is UnLikeEvent) {
      yield LikePostLoadingState();

      try {
        final userId = event.userId.replaceAll('.0', '');
        isLiked = !await likePostRepository.unLikePost(
            postId: event.postId, userId: userId);
        print(isLiked);
        yield UnLikePostLoadedState(disLiked: isLiked);
      } catch (e) {
        dev.log('Error in fetcing posts: $e', name: LOG_NAME);
        yield LikePostErrorState(response: false);
      }
    }
  }
}
