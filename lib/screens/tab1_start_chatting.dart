import 'package:chatapp/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_details_bloc/user_fetch_bloc.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import '../constants/textstyles_constants.dart';

class StartChatting extends StatelessWidget {
  String userName;
  StartChatting(this.userName);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAPIBloc, UserAPIState>(
      builder: (context, state) {
        if (state is InitialUserAPIState) {
          BlocProvider.of<UserAPIBloc>(context).add(
            FetchUserAPIEvent(),
          );
          return const Center(
            child: kInitialMessageState,
          );
        } else if (state is LoadedUserAPIState) {
          return Scaffold(
            body: Center(
              child: state.chatlist.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [kGreen, kBrightGreen],
                            ),
                            color: kGreen,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const CircleAvatar(
                            backgroundColor: kWhite,
                            child: Icon(
                              Icons.check,
                              color: kGreen,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          kYouHaventChattedYet,
                          style: kYouHaventChattedYetStyle
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [kGreen, kBrightGreen],
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: kTransparent,
                              shadowColor: kTransparent,
                            ),
                            onPressed: () {},
                            child: kStartChattingg,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              const SizedBox(
                                width: 100,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: kWelcome,
                                      style: kWelcomeStye,
                                    ),
                                    TextSpan(
                                      text: userName,
                                      style: kUserNameStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 15),
                            child: ListView.builder(
                              padding: const EdgeInsets.all(0),
                              itemCount: state.chatlist.length,
                              itemBuilder: ((context, index) {
                                return state.chatlist[index].name != userName
                                    ? ListTile(
                                        leading: Container(
                                          padding: const EdgeInsets.all(0),
                                          child: ClipOval(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(
                                                  30),
                                              child: Image.network(
                                                  state.chatlist[index].photo,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          state.chatlist[index].name,
                                          style: kChatlistUsernameBoldStyle),
                                        subtitle: kLastChat,
                                        trailing: const Text(
                                          "9:50 AM",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: ((context) {
                                                return ChatScreen(
                                                    state.chatlist[index],
                                                    userName);
                                              }),
                                            ),
                                          );
                                        },
                                      )
                                    : const SizedBox();
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          );
        } else if (state is ErrorUserAPIState) {
          return const Center(
            child: Text(
              kErrorOccured,
              style: kErrorOccuredStyle,
            ),
          );
        }
        return const Center(
          child: kNeitherInitialNorLoadedState,
        );
      },
    );
  }
}

/*  


https://images.unsplash.com/photo-1636278697183-89bd33b92cf0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGZ1bm55JTIwY2F0fGVufDB8fDB8fA%3D%3D&w=1000&q=80
https://www.gannett-cdn.com/presto/2020/06/05/PCHH/a6ef27ac-2d9c-4983-b7ef-d7ac83282656-Cat_with_Popcorn.png?width=660&height=826&fit=crop&format=pjpg&auto=webp
data:image/jpeg;base64,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
https://s5.favim.com/orig/69/analog-animal-black-cat-cat-Favim.com-654103.jpg
https://pittnews.com/wp-content/uploads/2017/11/Cat-Film-Festival_Courtesy-Casey-Taylor.jpg
https://images.squarespace-cdn.com/content/v1/5910d4dfe6f2e150b0706e20/1506377859725-PMTOZ4P40MKFZC1DZ99F/guesswhatanothercat.png?format=1500w
https://thumbs.dreamstime.com/b/ragdoll-cat-shot-analogue-film-portrait-nnimage-taken-full-frame-camera-140092783.jpg


*/
