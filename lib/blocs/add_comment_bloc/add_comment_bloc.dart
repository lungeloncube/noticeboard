import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_event.dart';
import 'package:digital_notice_board/blocs/add_comment_bloc/add_comment_state.dart';
import 'package:digital_notice_board/data/repositories/add_comment_repository/add_comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  static const LOG_NAME = 'bloc.add_comment';
  final AddCommentRepository addCommentRepository;
  bool response;

  CommentBloc({CommentState initialState, @required this.addCommentRepository})
      : super(initialState);
  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is AddCommentEvent) {
      yield CommentLoadingState();

      try {
        response = await addCommentRepository.addComment(
            postId: event.postId,
            branchId: event.branchId,
            userId: event.userId,
            comment: event.comment);
        print(response);
        yield CommentLoadedState(commented: response);
      } catch (e) {
        dev.log('Error in fetching posts: $e', name: LOG_NAME);
        yield CommentErrorState(response: false);
      }
    }
  }
}
