import 'dart:convert';
import 'package:chatapp/data/message_details/messages_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

postMessages(String sender, String message, String receiver) async {
  try {
    /// get

    var getResponse = await http.get(
      Uri.parse("http://127.0.0.1:3000/messagesBetweenTwoUsers"),
    );
    if (getResponse.statusCode == 200) {
      var jsonData = jsonDecode(getResponse.body);
      var messagesModel = MessagesModel.fromJson(jsonData);

      debugPrint(
        jsonData.containsKey(sender + receiver).toString(),
      );
      Map<String, List<Message>> newChat = {};
      if (!(jsonData.containsKey(sender + receiver))) {
        newChat = {(sender + receiver): []};
      }

      // Map<String, List<Message>> newChat = {(sender + receiver): []};
      newChat.forEach((key, value) {
        print("the keys in NEWCHAT are: $key");
      });

      if (!messagesModel.senderReceiverToMessagesMap
          .containsKey(sender + receiver)) {
        messagesModel.senderReceiverToMessagesMap.addAll(newChat);
      }

      /// appending messages
      List<Message> messageList =
          messagesModel.senderReceiverToMessagesMap[(sender + receiver)]!;
      print("sender $sender and receiver $receiver");
      messageList.add(
        Message(senderName: sender, message: message),
      );

      /// appending messages

      /// appending map
      // Map<String, List<Message>>
      newChat = {(sender + receiver): messageList};

      // if (messagesModel.senderReceiverToMessagesMap.isEmpty) {
      messagesModel.senderReceiverToMessagesMap.addAll(newChat);
      // }

      print(
          " messagesModel.senderReceiverToMessagesMap ${messagesModel.senderReceiverToMessagesMap}");

      /// appending map

      var postResponse = await http.post(
        Uri.parse("http://127.0.0.1:3000/messagesBetweenTwoUsers"),
        body: jsonEncode(messagesModel.senderReceiverToMessagesMap),
        headers: <String, String>{'Content-Type': 'application/json'},
      );
    }
  } catch (error) {
    debugPrint("ERROR IN MESSAGE POST BODY: $error");
  }
}


      ///appending keys
      // List<String> senderReceiverKeysList = [];
      // String senderPlusReceiverKey = sender + receiver;
      // print(senderPlusReceiverKey);
      // messagesModel.senderReceiverToMessagesMap.forEach((key, value) {
      //   senderReceiverKeysList.add(key);
      // });
      // print("KEYS LIST: $senderReceiverKeysList");
      // messagesModel.senderReceiverToMessagesMap.forEach((key, value) {
      //   print('key is $key');
      // });

      ///appending keys
     
     
     
      
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