import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_details_model.dart';

Future<List<UserDetailsModel>> postUser(String UserID, String imageURL) async {
  try {
    var postResponse =
        await http.post(Uri.parse("http://127.0.0.1:3000/users"), body: {
      "name": UserID,
      "photo": imageURL,
    });

    if (postResponse.statusCode == 200) {
      String postData = postResponse.body;
      List jsonData = jsonDecode(postData);
      var postResult = jsonData
          .map(
            (e) => UserDetailsModel.fromJson(e),
          )
          .toList();
      debugPrint(
        "the POST - USER result is: ${postResult.toString()}",
      );
      return postResult;
    } else {
      return [];
    }
  } catch (error) {
    debugPrint("ERROR IN POST - USER BODY: $error");
  }
  return [];
}
