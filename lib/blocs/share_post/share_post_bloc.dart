import 'package:digital_notice_board/blocs/share_post/share_post_event.dart';
import 'package:digital_notice_board/blocs/share_post/share_post_state.dart';
import 'package:digital_notice_board/data/repositories/share_post_repository/share_post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class SharePostBloc extends Bloc<SharePostEvent, SharePostState> {
  static const LOG_NAME = 'bloc.share_post';
  final SharePostRepository sharePostRepository;
  bool response;

  SharePostBloc(
      {SharePostState initialState, @required this.sharePostRepository})
      : super(initialState);
  @override
  Stream<SharePostState> mapEventToState(
      SharePostEvent event,
      ) async* {
    if (event is ShareEvent) {
      yield SharePostLoadingState();

      try {
        response = await sharePostRepository.sharePost(
            postText: event.postText,
            branchId: event.branchId,
            userId: event.userId,
            file: event.file,
            categoryId:event.categoryId,
            filename:event.filename);
        print(response);
        yield SharePostLoadedState(shared: response);
      } catch (e) {
        dev.log('Error in share_post_bloc: $e', name: LOG_NAME);
        yield SharePostErrorState(response: false);
      }
    }
  }
}
