part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class FetchMessagesEvent extends MessageEvent {
  String sender;
  String receiver;
  FetchMessagesEvent(this.receiver, this.sender);
}

class SendMessageEvent extends MessageEvent {
  String? senderr;
   String? receiverr;
  final MessagesModel messages;
  // final List<UserDetailsModel> sender;
  // final List<UserDetailsModel> receiver;
  SendMessageEvent(
      {required this.messages,
      // required this.receiver,
      // required this.sender,
      required this.senderr,
      required this.receiverr});
}
