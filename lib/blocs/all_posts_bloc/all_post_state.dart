import 'package:digital_notice_board/data/models/all_posts_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AllPostsState extends Equatable {
  const AllPostsState();
  @override
  List<Object> get props => [];
}

class AllPostsInitial extends AllPostsState {}

class AllPostsLoadingState extends AllPostsState {}

class AllPostsLoadedState extends AllPostsState {
  final List<AllPostsModel> allPostsModel;

  AllPostsLoadedState({@required this.allPostsModel});
  @override
  List<Object> get props => [allPostsModel];
}

class AllPostsErrorState extends AllPostsState {
  final String message;

  AllPostsErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
