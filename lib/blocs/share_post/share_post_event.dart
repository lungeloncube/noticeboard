import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SharePostEvent extends Equatable {
  const SharePostEvent();
  @override
  List<Object> get props => [];
}

class ShareEvent extends SharePostEvent {
  final String postText;
  final String userId;
  final File file;
  final String categoryId;
  final String branchId;
  final String filename;
  final String mediaType;

  ShareEvent(
      {@required this.filename,
      @required this.mediaType,
      @required this.categoryId,
      @required this.file,
      @required this.userId,
      @required this.postText,
      @required this.branchId});

  @override
  List<Object> get props =>
      [postText, userId, file, postText, branchId, filename, mediaType];
}
