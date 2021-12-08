import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SharePostState extends Equatable {
  const SharePostState();
  @override
  List<Object> get props => [];
}

class SharePostInitial extends SharePostState {}

class SharePostLoadingState extends SharePostState {}

class SharePostLoadedState extends SharePostState {
  final bool shared;

  SharePostLoadedState({@required this.shared});
  @override
  List<Object> get props => [shared];
}


class SharePostErrorState extends SharePostState {
  final bool response;

  SharePostErrorState({@required this.response});

  @override
  List<Object> get props => [response];
}
