import 'dart:convert';
import 'package:digital_notice_board/data/functions/general_functions.dart';
import 'package:digital_notice_board/res/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:developer' as dev;

class AddCommentProvider {
  static const String LOG_NAME = 'screen.AddCommentProvider';
  final Client client;

  AddCommentProvider({@required this.client});

  Future addComment(
      String branchId, String postId, String userId, String comment) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.addCommentUrl}$branchId';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(<String, String>{
        'postId': postId,
        'userId': userId,
        "commentText": comment
      }),
    );
    if (response.statusCode == 201) {
      if (response.body.contains("Comment for a Post Created Successfully")) {
        return true;
      } else {
        return false;
      }
    }
    dev.log('In the add comment repository', name: LOG_NAME);
    throw Exception('An error occurred. Try again later.');
  }
}
