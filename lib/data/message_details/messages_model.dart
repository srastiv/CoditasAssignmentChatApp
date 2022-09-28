import 'package:meta/meta.dart';
import 'dart:convert';

class MessagesModel {
  MessagesModel({
    required this.senderReceiverToMessagesMap,
  });
  final Map<String, List<Message>> senderReceiverToMessagesMap;

  //factory MessagesModel.fromJSONArray(List<Message> sendReceive) => MessagesModel(messagesBetweenSenderReceiver: sendReceive);

  // factory MessagesModel.fromRawJson(String str) =>
  //     MessagesModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
  //  print("json is $json");
    Map<String, List<Message>> tempSendertoReceiverMessagesMap = {};
    var jsonKeys = json.keys;
    for (var key in jsonKeys) {
      var jsonMessageList = json[key];
      var messageList = fromDynamicMessageList(jsonMessageList);
      tempSendertoReceiverMessagesMap[key] = messageList;
      //print("LIST<MESSAGE> MESSAGE LIST : ${messageList}");
    }
    //print("tempSendertoReceiverMessagesMap: ${tempSendertoReceiverMessagesMap}");
    return MessagesModel(
        senderReceiverToMessagesMap: tempSendertoReceiverMessagesMap);
  }
  static List<Message> fromDynamicMessageList(dynamic jsonMesssageList) {
    //print("DYNAMIC JSONMESSAGELIST : $jsonMesssageList");
    List<Message> listOfMessages = [];

    for (var jsonMessage in jsonMesssageList) {
      listOfMessages.add(Message.fromJson(jsonMessage));
    }
    //print("LIST<MESSAGE> LISTOFMESSAGES : ${listOfMessages}");
    return listOfMessages;
  }

  // Map<String, dynamic> toJson() => {
  //       "name1name2": List<dynamic>.from(
  //           senderReceiverToMessagesMap.map((x) => x.toJson())),

  //     };
}

class Message {
  Message({
    required this.senderName,
    required this.message,
  });

  final String senderName;
  final String message;

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        senderName: json["senderName"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "senderName": senderName,
        "message": message,
      };
}
