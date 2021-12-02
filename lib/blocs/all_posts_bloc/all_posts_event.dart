import 'package:digital_notice_board/data/models/all_posts_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AllPostsEvent extends Equatable{
  const AllPostsEvent();
  @override
  List<Object> get props => [];

}
class FetchAllPostsEvents extends AllPostsEvent{
  FetchAllPostsEvents();
  @override
  List<Object> get props => [];
}