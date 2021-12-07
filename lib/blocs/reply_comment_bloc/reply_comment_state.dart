import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ReplyCommentState extends Equatable {
  const ReplyCommentState();
  @override
  List<Object> get props => [];
}

class ReplyCommentInitial extends ReplyCommentState {}

class ReplyCommentLoadingState extends ReplyCommentState {}

class ReplyCommentLoadedState extends ReplyCommentState {
  final bool replyCommented;

  ReplyCommentLoadedState({@required this.replyCommented});
  @override
  List<Object> get props => [replyCommented];
}

class ReplyCommentErrorState extends ReplyCommentState {
  final bool response;

  ReplyCommentErrorState({@required this.response});

  @override
  List<Object> get props => [response];
}
