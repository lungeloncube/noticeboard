import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  final bool commented;

  CommentLoadedState({@required this.commented});
  @override
  List<Object> get props => [commented];
}

class CommentErrorState extends CommentState {
  final bool response;

  CommentErrorState({@required this.response});

  @override
  List<Object> get props => [response];
}
