import 'package:digital_notice_board/blocs/all_posts_bloc/all_post_state.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_event.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_event.dart';
import 'package:digital_notice_board/blocs/like_post_bloc/like_post_state.dart';
import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:digital_notice_board/data/repositories/like_post_repository/like_post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  final LikePostRepository likePostRepository;
  bool response;

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
        response = await likePostRepository.likePost(
            postId: event.postId, userId: userId);
        print(response);
        yield LikePostLoadedState(liked: response);
      } catch (e) {
        yield LikePostErrorState(response: false);
      }
    }
  }
}
