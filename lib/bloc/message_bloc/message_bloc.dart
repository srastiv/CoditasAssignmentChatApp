import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chatapp/data/user_details/user_details_model.dart';
import 'package:chatapp/data/message_details/get_msgs.dart';
import '../../data/message_details/messages_model.dart';
import '../../data/message_details/post_msgs_data.dart';
part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitialState("John", "Jakiro")) {
    on<FetchMessagesEvent>((event, emit) async {
      var messages = await getMessages(event.sender, event.receiver);
      //print("MESSAGE BODY IN BLOC - MESSAGE-API-FETCH: ${messages}");
      emit(MessagesLoadedState(messages: messages, senderr: event.sender, receiverr: event.receiver));
    });
    on<ReceiveMessageEvent>(
      (event, emit) {
        emit(
          MessagesLoadedState(
              messages: event.messages,
              senderr: event.senderr!,
              receiverr: event.receiverr!),
        );
      },
    );
    on<SendMessageEvent>(
      (event, emit) async {
        var postMessage = await postMessages(event.senderr!
       // sender.toString()
        ,
            event.messages.toString(), event.receiverr!
           // receiver.toString()
            );
        emit(
          MessagesLoadedState(
              messages: event.messages,
              senderr: event.senderr!,
              receiverr: event.receiverr!),
        );
      },
    );
  }
}
