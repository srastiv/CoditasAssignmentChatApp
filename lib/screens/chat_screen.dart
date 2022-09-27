import 'package:chatapp/constants/color_constants.dart';
import 'package:chatapp/constants/text_constants.dart';
import 'package:chatapp/constants/textstyles_constants.dart';
import 'package:chatapp/data/user_details/user_details_model.dart';
import 'package:chatapp/data/message_details/post_msgs_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/message_bloc/message_bloc.dart';

class ChatScreen extends StatelessWidget {
  UserDetailsModel messageBodyElement;
  String userName;
  ChatScreen(this.messageBodyElement, this.userName);
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(bottom: 35, left: 20, right: 30, top: 60),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: kGrey),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kBrightGreen,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(0), // Border width

                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(20), // Image radius
                        child: Image.network(messageBodyElement.photo,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    messageBodyElement.name,
                    style: const TextStyle(
                        color: kBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: kLightGreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.call_outlined,
                            color: kBrightGreen,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: kLightGreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.video_call_outlined,
                            color: kBrightGreen,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: kLightGreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: kBrightGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///
            ///
            /// THE CHAT BODY STARTS FROM HERE
            ///
            ///
            BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageInitialState) {
                  const Text(
                      "yeap, your api didnt load msgs here, this is the inital state");

                  BlocProvider.of<MessageBloc>(context).add(
                    FetchMessagesEvent(state.sender, state.receiver),
                  );
                  return const Center(
                    child: Text(
                      kYourMessagesAreLoading,
                      style: TextStyle(color: kBlack),
                    ),
                  );
                } else if (state is MessagesLoadedState) {
                  // BlocProvider.of<MessageBloc>(context).add(
                  //   FetchMessagesEvent(state.receiverr, state.senderr),
                  //   // state.messages
                  // );
                  return Column(
                    children: [
                      Container(
                        height: 610,
                        padding: EdgeInsets.all(2),
                        child: ListView.separated(
                          itemCount: state
                              .messages
                              .senderReceiverToMessagesMap[
                                  state.senderr + state.receiverr]!
                              .length, //["JohnJakiro"]
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              margin: state
                                          .messages
                                          .senderReceiverToMessagesMap[
                                              state.senderr +
                                                  state.receiverr]![index]
                                          .senderName ==
                                      userName
                                  ? const EdgeInsets.only(left: 40)
                                  : const EdgeInsets.only(right: 40),
                              padding: const EdgeInsets.only(
                                  top: 15, left: 15, bottom: 10, right: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: state
                                              .messages
                                              .senderReceiverToMessagesMap[
                                                  state.senderr +
                                                      state.receiverr]![index]
                                              .senderName ==
                                          userName
                                      ? kLightGreen
                                      : kChatBubbleGrey),
                              child: state
                                          .messages
                                          .senderReceiverToMessagesMap[
                                              state.senderr +
                                                  state.receiverr]![index]
                                          .senderName ==
                                      userName
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(state
                                            .messages
                                            .senderReceiverToMessagesMap[
                                                state.senderr +
                                                    state.receiverr]![index]
                                            .message
                                            .toString()),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            Text(
                                              "9:45 AM",
                                              style: TextStyle(color: kGrey),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(state
                                            .messages
                                            .senderReceiverToMessagesMap[
                                                state.senderr +
                                                    state.receiverr]![index]
                                            .message
                                            .toString()),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: const [
                                            Text(
                                              "9:45 AM",
                                              style: TextStyle(color: kGrey),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: kGrey,
                                ),
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.attach_file,
                                      color: kGrey,
                                    ),
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: kGrey,
                                    ),
                                    SizedBox(
                                      width: 9,
                                    ),
                                  ],
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(17)),
                                  borderSide:
                                      BorderSide(width: 1, color: kGrey),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(17)),
                                  borderSide:
                                      BorderSide(width: 1, color: kGrey),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(17)),
                                  borderSide: BorderSide(
                                    width: 1,
                                  ),
                                ),
                                hintText: kTypeMessage,
                              ),
                            ),
                          ),

                          ///
                          ///
                          /// THE MESSAGE BOX ENDS FROM HERE
                          ///
                          ///

                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 40,
                            width: 50,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient:
                                  // messageController.text.length == 0 ||
                                  //         messageController.text == ' '
                                  //     ?
                                  //      const LinearGradient(
                                  //         begin: Alignment.topLeft,
                                  //         end: Alignment.bottomRight,
                                  //         colors: [kGrey, kChatBubbleGrey],
                                  //       )
                                  //     :
                                  const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [kGreen, kBrightGreen],
                              ),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: kTransparent, elevation: 0),
                              onPressed: () async {
                                debugPrint(
                                    "${state.receiverr} is receiver and ${state.senderr} is sender");
                                final String message = messageController.text;
                                String receiver = messageBodyElement.name;

                                message.length == 0 ||
                                        messageController.text == ' '
                                    ? null
                                    // : BlocProvider.of<MessageBloc>(context)
                                    //     .add(SendMessageEvent(
                                    //         messages: state.messages,
                                    //         //.senderReceiverToMessagesMap[(state.senderr+state.receiverr)]!,
                                    //         // receiver: state.receiver,
                                    //         // sender: state.sender,
                                    //         senderr: state.senderr,
                                    //         receiverr: state.receiverr));

                                    : await postMessages(
                                        userName, message, receiver);
                                BlocProvider.of<MessageBloc>(context).add(
                                  FetchMessagesEvent(
                                      state.receiverr, state.senderr),
                                  // state.messages
                                );
                                messageController.clear();
                              },
                              child: const Icon(Icons.send),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is MessageErrorState) {
                  return const Center(
                    child: Text(
                      kErrorOccured,
                      style: kChatScreenErrorOccuredStyle,
                    ),
                  );
                }
                return const Center(
                  child: kNeitherInitialNorLoadedState,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// {
//       "id": "2",
//       "name": "Mark",
//       "photo": "https://i.pinimg.com/originals/3c/c4/8f/3cc48f0d3c345afbd19c963623395ed2.jpg"
//     },
