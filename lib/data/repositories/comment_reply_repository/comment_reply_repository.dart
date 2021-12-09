import 'package:digital_notice_board/data/repositories/comment_reply_repository/comment_reply_provider.dart';
import 'package:flutter/material.dart';

class ReplyCommentRepository {
  final CommentReplyProvider commentReplyProvider;

  ReplyCommentRepository({@required this.commentReplyProvider});

  Future<bool> replyComment(
      {@required String commentId,
      @required String branchId,
      @required String userId,
      @required String comment}) async {
    var responseData = await commentReplyProvider.replyComment(
        branchId, commentId, userId, comment);
    if (responseData == null) {
      return null;
    }
    return responseData;
  }
}
