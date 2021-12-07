import 'package:digital_notice_board/blocs/individual_comment_bloc/individual_comment_event.dart';
import 'package:digital_notice_board/blocs/individual_comment_bloc/individual_comment_state.dart';
import 'package:digital_notice_board/data/models/comment_response.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class IndividualCommentBloc
    extends Bloc<IndividualCommentEvent, IndividualCommentState> {
  static const LOG_NAME = 'bloc.individual_Comment_bloc';
  final AllPostsRepository allPostsRepository;

  IndividualCommentBloc(
      {IndividualCommentState initialState, @required this.allPostsRepository})
      : super(initialState);
  @override
  Stream<IndividualCommentState> mapEventToState(
    IndividualCommentEvent event,
  ) async* {
    if (event is FetchCommentByIdEvents) {
      yield IndividualCommentLoadingState();

      try {
        var commentResponse = await allPostsRepository.getCommentById(
          commentId: event.commentId,
          branchId: event.branchId,
        );
        print(CommentResponse);
        yield IndividualCommentLoadedState(commentResponse: commentResponse);
      } catch (e) {
        dev.log('Error in fetcing individual comment: $e', name: LOG_NAME);
        yield IndividualCommentErrorState(
            message: "Error occurred while fetching comment");
      }
    }
  }
}
