import 'package:digital_notice_board/data/models/comment_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class IndividualCommentState extends Equatable {
  const IndividualCommentState();
  @override
  List<Object> get props => [];
}

class IndividualCommentInitial extends IndividualCommentState {}

class IndividualCommentLoadingState extends IndividualCommentState {}

class IndividualCommentLoadedState extends IndividualCommentState {
  final CommentResponse commentResponse;

  IndividualCommentLoadedState({@required this.commentResponse});
  @override
  List<Object> get props => [commentResponse];
}

class IndividualCommentErrorState extends IndividualCommentState {
  final String message;

  IndividualCommentErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
