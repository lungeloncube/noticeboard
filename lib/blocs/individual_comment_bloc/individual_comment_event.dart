import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class IndividualCommentEvent extends Equatable {
  const IndividualCommentEvent();
  @override
  List<Object> get props => [];
}

class FetchCommentByIdEvents extends IndividualCommentEvent {
  final String commentId;
  final String branchId;

  FetchCommentByIdEvents({@required this.commentId, @required this.branchId});
  @override
  List<Object> get props => [commentId, branchId];
}
