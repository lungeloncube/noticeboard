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
    print(response.body);

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

  Future getPostById(
      {@required String branchId, @required String postId}) async {
    var headers = await GeneralFunctions.getHeaders();
    var url = '${Url.postByIdUrl}/post/$postId/branch/$branchId';

    var response = await client.get(Uri.parse(url), headers: headers);
    print(response.body);

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
}
