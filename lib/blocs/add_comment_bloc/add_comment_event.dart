import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
  @override
  List<Object> get props => [];
}

class AddCommentEvent extends CommentEvent {
  final String postId;
  final String userId;
  final String branchId;
  final String comment;

  AddCommentEvent(
      {@required this.branchId,
      @required this.comment,
      @required this.userId,
      @required this.postId});

  @override
  List<Object> get props => [postId, userId];
}
