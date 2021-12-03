import 'package:digital_notice_board/data/models/posts_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AllPostsEvent extends Equatable {
  const AllPostsEvent();
  @override
  List<Object> get props => [];
}

class FetchAllPostsEvents extends AllPostsEvent {
  @override
  List<Object> get props => [];
}