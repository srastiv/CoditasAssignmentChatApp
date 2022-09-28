part of 'message_bloc.dart';

@immutable
abstract class MessageState {}

class MessageInitialState extends MessageState {
  // String senderr;
  // String receiverr;
  // MessageInitialState(this.receiverr, this.senderr);
}

class MessagesLoadedState extends MessageState {
  final MessagesModel messages;
  String senderr;
  String receiverr;
  MessagesLoadedState(
      {required this.messages, required this.senderr, required this.receiverr});
}

class MessageErrorState extends MessageState {
  final error;
  MessageErrorState({this.error});
}
