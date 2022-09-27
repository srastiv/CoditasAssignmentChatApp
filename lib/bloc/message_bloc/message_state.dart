part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitialState extends MessageState {
  String sender;
  String receiver;
  MessageInitialState(this.receiver, this.sender);
}

class MessagesLoadedState extends MessageState {
  final MessagesModel messages;
  String senderr;
  String receiverr;
  MessagesLoadedState({required this.messages, required this.senderr, required this.receiverr});
}

class MessageErrorState extends MessageState {
  final error;
  MessageErrorState({this.error});
}
