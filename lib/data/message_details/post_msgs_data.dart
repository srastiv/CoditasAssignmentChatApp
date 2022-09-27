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
      // Map<String, String> tempMap = {"senderName": sender, "message": message};
      //print("$sender sender and $receiver receiver");
      List<Message> messageList =
          messagesModel.senderReceiverToMessagesMap[(sender + receiver)]!;
      messageList.add(Message(senderName: sender, message: message));
      //print("the messageLIST : $messageList");

  

      print(jsonData.containsKey(sender + receiver)); // or "JohnJakiro"

      String senderPlusReceiverKey = (sender + receiver);
      
      // messagesModel.senderReceiverToMessagesMap[(sender + receiver)];

      var postResponse = await http
          .post(Uri.parse("http://127.0.0.1:3000/messagesBetweenTwoUsers"),
              body: jsonEncode({
                (sender + receiver): messageList,
              }),

              // {
              //   (sender + receiver): [
              //     messageList
              //   ],
              // }

              // {
              //   (sender + receiver): [
              //     {"senderName": sender, "message": message}
              //   ],
              // }
              headers: <String, String>{'Content-Type': 'application/json'});
    }
  } catch (error) {
    debugPrint("ERROR IN MESSAGE POST BODY: $error");
  }
}



//  "messagesBetweenTwoUsers": {
//     "JohnJakiro": [
//       {
//         "senderName": "John",
//         "message": "Hey, how are you?"
//       },
//       {
//         "senderName": "John",
//         "message": "Do you remember me?"
//       },
//       {
//         "senderName": "Jakiro",
//         "message": "Oh, of course!"
//       }
//     ],
//     "JohnMark": [
//       {
//         "senderName": "John",
//         "message": "I am leaving for dinner"
//       },
//       {
//         "senderName": "Mark",
//         "message": "See you there"
//       }
//     ]
//   }













//  "messagesBetweenTwoUsers": {
//     "name1name2": [
//       {
//         "senderName": "senderName",
//         "message": "test message"
//       }
//     ]
//   }

// inside if


      // var jsonData = jsonDecode(postData);
      // print(jsonData);
      // print("POST MSG JSONDATA: $jsonData");
      //debugPrint("STRING MESSAGE POSTDATA: $postData");
      // debugPrint("MESSAGE POST RESPONSE : ${postResponse.body}");
      // debugPrint("POST RESPONSE STATUSCODE: ${postResponse.statusCode}");

      // var postResult = jsonData[0] //ERROR ON THIS LINE
      //     .map(
      //   (e) {
      //     MessageModel messageModel = MessageModel.fromJson(e);
      //     print(messageModel);
      //   },
      // );

      // debugPrint(
      //   " POST MESSAGES RESULT: ${postResult.toString()}",
      // );
      // return postResult;