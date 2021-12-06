import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LikePostEvent extends Equatable {
  const LikePostEvent();
  @override
  List<Object> get props => [];
}

class LikeEvent extends LikePostEvent {
  final String postId;
  final String userId;

  LikeEvent({@required this.userId, @required this.postId});

  @override
  List<Object> get props => [postId, userId];
}
class UnLikeEvent extends LikePostEvent {
  final String postId;
  final String userId;

  UnLikeEvent({@required this.userId, @required this.postId});

  @override
  List<Object> get props => [postId, userId];
}
