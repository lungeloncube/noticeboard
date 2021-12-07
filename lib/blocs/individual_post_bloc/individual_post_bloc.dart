import 'package:digital_notice_board/blocs/individual_post_bloc/individual_post_state.dart';
import 'package:digital_notice_board/blocs/individual_post_bloc/individual_post_event.dart';
import 'package:digital_notice_board/data/models/individual_post_response.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class IndividualPostBloc
    extends Bloc<IndividualPostEvent, IndividualPostState> {
  static const LOG_NAME = 'bloc.individual_post_bloc';
  final AllPostsRepository allPostsRepository;
  IndividualPostResponse postResponse;
  IndividualPostBloc(
      {IndividualPostState initialState, @required this.allPostsRepository})
      : super(initialState);
  @override
  Stream<IndividualPostState> mapEventToState(
    IndividualPostEvent event,
  ) async* {
    if (event is FetchPostByIdEvents) {
      yield IndividualPostLoadingState();

      try {
        postResponse = await allPostsRepository.getPostById(
          postId: event.postId,
          branchId: event.branchId,
        );
        print(postResponse);
        yield IndividualPostLoadedState(individualPostResponse: postResponse);
      } catch (e) {
        dev.log('Error in fetcing individual post: $e', name: LOG_NAME);
        yield IndividualPostErrorState(
            message: "Error occurred while fetching post");
      }
    }
  }
}
