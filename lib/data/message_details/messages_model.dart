import 'package:meta/meta.dart';
import 'dart:convert';

class MessagesModel {
  MessagesModel({
    required this.conversationsMap,
  });
  final Map<String, List<Message>> conversationsMap;

  //factory MessagesModel.fromJSONArray(List<Message> sendReceive) => MessagesModel(messagesBetweenSenderReceiver: sendReceive);

  // factory MessagesModel.fromRawJson(String str) =>
  //     MessagesModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<Message>> tempSendertoReceiverMessagesMap = {};
    var jsonKeys = json.keys;
    for (var key in jsonKeys) {
      var jsonMessageList = json[key];
      var messageList = fromDynamicMessageList(jsonMessageList);
      tempSendertoReceiverMessagesMap[key] = messageList;
    }

    return MessagesModel(conversationsMap: tempSendertoReceiverMessagesMap);
  }
  static List<Message> fromDynamicMessageList(dynamic jsonMesssageList) {
    List<Message> listOfMessages = [];

    for (var jsonMessage in jsonMesssageList) {
      listOfMessages.add(Message.fromJson(jsonMessage));
    }

    return listOfMessages;
  }

  void addToConversation(String sender, String receiver, Message message) {
    String key1 = sender + receiver;
    String key2 = receiver + sender;
    bool containsKey1 = conversationsMap.containsKey(key1);
    bool containsKey2 = conversationsMap.containsKey(key2);

    if (containsKey1) {
      List<Message> existingMessages = conversationsMap[key1]!;
      existingMessages.add(message);
      conversationsMap[key1] = existingMessages;
      return;
    }
    if (containsKey2) {
      List<Message> existingMessages = conversationsMap[key2]!;
      existingMessages.add(message);
      conversationsMap[key2] = existingMessages;
       return;
    }
    conversationsMap[key1] = [message];
    //throw Exception("Expected atleast one of the keys to be present");
  }

  Map<String, List<Message>> getConversation(String sender, String receiver) {
    String key1 = sender + receiver;
    String key2 = receiver + sender;
    bool containsKey1 = conversationsMap.containsKey(key1);
    bool containsKey2 = conversationsMap.containsKey(key2);

    if (containsKey1) {
      return {key1: conversationsMap[key1]!};
    }
    if (containsKey2) {
      return {key2: conversationsMap[key2]!};
    }

    throw Exception("Expected atleast one of the keys to be present");
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
