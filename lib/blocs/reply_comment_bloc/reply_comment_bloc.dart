import 'package:digital_notice_board/blocs/reply_comment_bloc/reply_comment_event.dart';
import 'package:digital_notice_board/blocs/reply_comment_bloc/reply_comment_state.dart';
import 'package:digital_notice_board/data/repositories/comment_reply_repository/comment_reply_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class ReplyCommentBloc extends Bloc<CommentReplyEvent, ReplyCommentState> {
  static const LOG_NAME = 'bloc.reply_comment';
  final ReplyCommentRepository replyCommentRepository;
  bool response;

  ReplyCommentBloc(
      {ReplyCommentState initialState, @required this.replyCommentRepository})
      : super(initialState);
  @override
  Stream<ReplyCommentState> mapEventToState(
    CommentReplyEvent event,
  ) async* {
    if (event is AddCommentReplyEvent) {
      yield ReplyCommentLoadingState();

      try {
        response = await replyCommentRepository.replyComment(
            commentId: event.commentId,
            branchId: event.branchId,
            userId: event.userId,
            comment: event.comment);
        print(response);
        yield ReplyCommentLoadedState(replyCommented: response);
      } catch (e) {
        dev.log('Error in reply comment: $e', name: LOG_NAME);
        yield ReplyCommentErrorState(response: false);
      }
    }
  }
}
