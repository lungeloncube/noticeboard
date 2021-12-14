import 'dart:io';

import 'package:digital_notice_board/data/repositories/share_post_repository/share_post_provider.dart';
import 'package:flutter/material.dart';

class SharePostRepository {
  final SharePostProvider sharePostProvider;

  SharePostRepository({@required this.sharePostProvider});

  Future<bool> sharePost(
      {@required String branchId,
      @required String postText,
      @required String categoryId,
      @required String userId,
      @required File file,
      @required String filename,
      @required String mediaType}) async {
    var responseData = await sharePostProvider.sharePost(
        categoryId: categoryId,
        userId: userId,
        file: file,
        branchId: branchId,
        postText: postText,
        filename: filename,
        mediaType: mediaType);
    if (responseData == null) {
      return null;
    }
    return responseData;
  }
}
