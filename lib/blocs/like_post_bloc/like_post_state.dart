import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LikePostState extends Equatable {
  const LikePostState();
  @override
  List<Object> get props => [];
}

class LikePostInitial extends LikePostState {}

class LikePostLoadingState extends LikePostState {}

class LikePostLoadedState extends LikePostState {
  final bool liked;

  LikePostLoadedState({@required this.liked});
  @override
  List<Object> get props => [liked];
}

class UnLikePostLoadedState extends LikePostState {
  final bool disLiked;

  UnLikePostLoadedState({@required this.disLiked});
  @override
  List<Object> get props => [disLiked];
}

class LikePostErrorState extends LikePostState {
  final bool response;

  LikePostErrorState({@required this.response});

  @override
  List<Object> get props => [response];
}
