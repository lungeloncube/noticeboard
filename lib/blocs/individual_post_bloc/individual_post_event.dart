import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class IndividualPostEvent extends Equatable {
  const IndividualPostEvent();
  @override
  List<Object> get props => [];
}

class FetchPostByIdEvents extends IndividualPostEvent {
  String postId;
  String branchId;

  FetchPostByIdEvents({@required this.postId, @required this.branchId});
  @override
  List<Object> get props => [postId, branchId];
}
