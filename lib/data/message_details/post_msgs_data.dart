import 'dart:convert';
import 'package:chatapp/data/message_details/messages_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

postMessages(String sender, String message, String receiver) async {
  try {
    var getResponse = await http.get(
      Uri.parse("http://127.0.0.1:3000/messagesBetweenTwoUsers"),
    );
    if (getResponse.statusCode == 200) {
      var jsonData = jsonDecode(getResponse.body);
      var messagesModel = MessagesModel.fromJson(jsonData);

      Message newMessage = Message(senderName: sender, message: message);
      messagesModel.addToConversation(sender, receiver, newMessage);

      // debugPrint(
      //   jsonData.containsKey(sender + receiver).toString(),
      // );

      // Map<String, List<Message>> newChat = {};
      // if (!(jsonData.containsKey(sender + receiver)) &&
      //     !(jsonData.containsKey(receiver + sender))) {
      //   newChat = {(sender + receiver): []};
      // }

      // newChat.forEach((key, value) {
      //   print("the keys in NEWCHAT are: $key");
      // });

      // if ((!(messagesModel.conversationsMap.containsKey(sender + receiver))) &&
      //     (!(messagesModel.conversationsMap.containsKey(receiver + sender)))) {
      //   messagesModel.conversationsMap.addAll(newChat);
      // }

      // /// appending messages
      // List<Message> messageList = [];

      // if (!(messagesModel.conversationsMap.containsKey(sender + receiver))) {
      //   messageList = messagesModel.conversationsMap[(receiver + sender)]!;
      // } else {
      //   messageList = messagesModel.conversationsMap[(sender + receiver)]!;
      // }

      // messageList.add(
      //   Message(senderName: sender, message: message),
      // );
      // debugPrint(
      //   jsonData.containsKey(sender + receiver).toString(),
      // );

      // /// appending messages

      // /// appending map
      // if (!(messagesModel.conversationsMap.containsKey(sender + receiver)) ||
      //     !(messagesModel.conversationsMap.containsKey(receiver + sender))) {
      //   newChat = {(sender + receiver): messageList};
      //   messagesModel.conversationsMap.addAll(newChat);
      // }
      // messagesModel.conversationsMap[sender + receiver] = messageList;

      /// appending map

      var postResponse = await http.post(
        Uri.parse("http://127.0.0.1:3000/messagesBetweenTwoUsers"),
        body: jsonEncode(messagesModel.conversationsMap),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
    }
  } catch (error) {
    debugPrint("ERROR IN MESSAGE POST BODY: $error");
  }
}

///body: jsonEncode(),
        // {
        //   (sender + receiver):
        //     messageList,
        // }

        // {
        //   (sender + receiver): [
        //     {"senderName": sender, "message": message}
        //   ],
        // }