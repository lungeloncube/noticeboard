import 'package:digital_notice_board/data/functions/general_functions.dart';
import 'package:digital_notice_board/res/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;

class LikePostProvider {
  final Client client;

  LikePostProvider({@required this.client});

  Future likePost(String postId, String userId) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.likeUrl}user/$userId/post/$postId';
    var response = await client.post(Uri.parse(url), headers: headers);
    if (response.statusCode == 201) {
      if (response.body.contains("New Liked Post") ||
          response.body.contains("Liked a Post")) {
        return true;
      } else {
        return false;
      }
    }
    throw Exception('An error occurred. Try again later.');
  }

  Future unLikePost(String postId, String userId) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.unLikeUrl}user/$userId/post/$postId';
    var response = await client.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 204) {
      if (response.body.contains("")) {
        return true;
      } else {
        return false;
      }
    }
    throw Exception('An error occurred. Try again later.');
  }
}
