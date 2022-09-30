import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'messages_model.dart';

Future<MessagesModel> getMessages(String sender, String receiver) async {
  try {
    var getResponse = await http.get(
      Uri.parse("http://127.0.0.1:3000/messagesBetweenTwoUsers"),
    );
    if (getResponse.statusCode == 200) {
      String getData = getResponse.body;

      var jsonData = jsonDecode(getData);
      var getResult = MessagesModel.fromJson(jsonData);

      return getResult;
    }
  } catch (error) {
    debugPrint("ERROR IN FETCHING FROM GET-MESSAGE-API: $error");
  }
  throw Exception('ERROR IN GETTING MESSAGES');
}
