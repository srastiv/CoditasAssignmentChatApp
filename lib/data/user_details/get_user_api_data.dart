import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_details_model.dart';

Future<List<UserDetailsModel>> getUserDetails() async {
  try {
    var getResponse = await http.get(
      Uri.parse("http://127.0.0.1:3000/users"),
    );
    if (getResponse.statusCode == 200) {
      String getData = getResponse.body;
      List jsonData = jsonDecode(getData);
      var getResult = jsonData
          .map(
            (e) => UserDetailsModel.fromJson(e),
          )
          .toList();
      return getResult;
    } else {
      return [];
    }
  } catch (error) {
    debugPrint("ERROR IN FETCHING FROM USER-API: $error");
  }
  return [];
}
