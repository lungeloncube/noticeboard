import 'package:digital_notice_board/blocs/all_posts_bloc/all_post_state.dart';
import 'package:digital_notice_board/blocs/all_posts_bloc/all_posts_event.dart';
import 'package:digital_notice_board/data/models/all_posts_model.dart';
import 'package:digital_notice_board/data/repositories/post_repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPostsBloc extends Bloc<AllPostsEvent, AllPostsState> {
  final AllPostsRepository allPostsRepository;
  List<AllPostsModel> allPostsModel;
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
      allPostsModel = await allPostsRepository.getAllPosts();
      print(allPostsModel[0]);
      yield AllPostsLoadedState(allPostsModel: allPostsModel);
    } catch (e) {
      yield AllPostsErrorState(message: "Error occurred while fetching posts");
    }
  }
}
