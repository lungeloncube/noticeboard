import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CommentReplyEvent extends Equatable {
  const CommentReplyEvent();
  @override
  List<Object> get props => [];
}

class AddCommentReplyEvent extends CommentReplyEvent {
  final String commentId;
  final String userId;
  final String branchId;
  final String comment;

  AddCommentReplyEvent(
      {@required this.branchId,
      @required this.comment,
      @required this.userId,
      @required this.commentId});

  @override
  List<Object> get props => [commentId, userId];
}
