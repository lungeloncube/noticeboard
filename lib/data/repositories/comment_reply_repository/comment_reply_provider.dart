import 'dart:convert';

import 'package:digital_notice_board/data/functions/general_functions.dart';
import 'package:digital_notice_board/res/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:developer' as dev;

class CommentReplyProvider {
  static const String LOG_NAME = 'screen.CommentReply';
  final Client client;

  CommentReplyProvider({@required this.client});

  Future addComment(
      String branchId, String commentId, String userId, String comment) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.commentReplyUrl}$branchId';

    print("......" + url);

    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(<String, String>{
        'commentId': commentId,
        'userId': userId,
        "commentText": comment
      }),
    );
    if (response.statusCode == 201) {
      if (response.body
          .contains("Comment for a Comment Created Successfully")) {
        return true;
      } else {
        return false;
      }
    }
    dev.log('In the reply comment repository', name: LOG_NAME);
    throw Exception('An error occurred. Try again later.');
  }
}
