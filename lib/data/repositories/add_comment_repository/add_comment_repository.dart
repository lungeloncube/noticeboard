import 'package:digital_notice_board/data/repositories/add_comment_repository/add_comment_provider.dart';
import 'package:flutter/material.dart';

class AddCommentRepository {
  final AddCommentProvider addCommentProvider;

  AddCommentRepository({@required this.addCommentProvider});

  Future<bool> addComment(
      {@required String postId,
      @required String branchId,
      @required String userId,
      @required String comment}) async {
    var responseData =
        await addCommentProvider.addComment(branchId, postId, userId, comment);
    if (responseData == null) {
      return null;
    }
    return responseData;
  }
}
