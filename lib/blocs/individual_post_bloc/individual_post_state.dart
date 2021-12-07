import 'package:digital_notice_board/data/models/individual_post_response.dart';
import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class IndividualPostState extends Equatable {
  const IndividualPostState();
  @override
  List<Object> get props => [];
}

class IndividualPostInitial extends IndividualPostState {}

class IndividualPostLoadingState extends IndividualPostState {}

class IndividualPostLoadedState extends IndividualPostState {
  final IndividualPostResponse individualPostResponse;

  IndividualPostLoadedState({@required this.individualPostResponse});
  @override
  List<Object> get props => [individualPostResponse];
}

class IndividualPostErrorState extends IndividualPostState {
  final String message;

  IndividualPostErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
