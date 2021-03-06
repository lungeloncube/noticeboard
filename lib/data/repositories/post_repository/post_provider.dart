import 'dart:convert';
import 'package:digital_notice_board/data/functions/general_functions.dart';
import 'package:digital_notice_board/res/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;

class AllPostsProvider {
  final Client client;
  AllPostsProvider({@required this.client});

  Future getAllPosts() async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.allPosts}';
    var response = await client.get(Uri.parse(url), headers: headers);
    var jsonResponse = response.body;
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return json.decode(jsonResponse);
      } else {
        print("nothing in the post body");
      }
    }
    throw Exception('An error occurred. Try again later');
  }

  Future getPostById(
      {@required String branchId, @required String postId}) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.postByIdUrl}/post/$postId/branch/$branchId';
    var response = await client.get(Uri.parse(url), headers: headers);
    var jsonResponse = response.body;
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return json.decode(jsonResponse);
      } else {
        print("nothing in the post body");
      }
    }
    throw Exception('An error occurred. Try again later.');
  }

  Future getCommentById(
      {@required String branchId, @required String commentId}) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.commentIdUrl}/comment/$commentId/branch/$branchId';
    var response = await client.get(Uri.parse(url), headers: headers);
    var jsonResponse = response.body;
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return json.decode(jsonResponse);
      } else {
        print("nothing in the comment body");
      }
    }
    throw Exception('An error occurred. Try again later.');
  }


   Future getMedia(
      {@required String mediaUrl}) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = mediaUrl;
    var response = await client.get(Uri.parse(url), headers: headers);
    var jsonResponse = response.body;
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return json.decode(jsonResponse);
      } else {
        print("nothing in the comment body");
      }
    }
    throw Exception('An error occurred. Try again later.');
  }
}
