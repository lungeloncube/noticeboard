import 'dart:io';
import 'package:digital_notice_board/data/functions/general_functions.dart';
import 'package:digital_notice_board/res/urls.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class SharePostProvider {
  static const String LOG_NAME = 'screen.SharePostProvider';

  SharePostProvider();

  Future<bool> sharePost(
      {@required String postText,
      @required String categoryId,
      @required String userId,
      @required File file,
      @required String branchId,
      @required filename}) async {
    var headers = await GeneralFunctions.getMultiPartHeaders();
    var url = '${Url.sharePostUrl}$branchId';
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.files.add(http.MultipartFile.fromBytes(
        'file', File(file.path).readAsBytesSync(),
        filename: file.path.split("/").last));
    request.headers.addAll(headers);
    request.fields['postText'] = postText;
    request.fields['categoryId'] = categoryId;
    request.fields['userId'] = userId;

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
