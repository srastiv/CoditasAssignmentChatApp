import 'package:chatapp/bloc/user_details_bloc/user_fetch_bloc.dart';
import 'package:chatapp/data/user_details/post_user_api.dart';
import 'package:chatapp/data/user_details/user_details_model.dart';
import 'package:chatapp/screens/tab1_start_chatting.dart';
import 'package:chatapp/screens/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';

class UserAuthentication extends StatelessWidget {
  final TextEditingController userIDcontroller = TextEditingController();
  final TextEditingController photoURLcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserAPIBloc, UserAPIState>(
        builder: (context, state) {
          if (state is InitialUserAPIState) {
            BlocProvider.of<UserAPIBloc>(context).add(FetchUserAPIEvent());
            return const Text("initial state on login page");
          } else if (state is LoadedUserAPIState) {
            return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: RichText(
                        text: const TextSpan(
                          text: "Welcome to ",
                          style: TextStyle(
                            color: kBrightGreen,
                            fontSize: 20,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'WHATSUP!',
                              style: TextStyle(
                                  color: kBrightGreen,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: ((text) {
                        if (text == null || text.isEmpty) {
                          return kUserIDisEmpty;
                        }
                        return null;
                      }),
                      controller: userIDcontroller,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kBlack,
                        ),
                        hintText: kWhatdoPeopleCallYou,
                        labelText: kEnterYourUserID,
                        labelStyle: TextStyle(color: kBlack),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGrey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return kPasswordIsEmpty;
                        }
                        return null;
                      },
                      controller: photoURLcontroller,
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.image,
                          color: kBlack,
                        ),
                        hintText: kPasteImageURL,
                        labelText: kURLforProfilePhoto,

                        // hintText: 'Who do you want to text?',
                        // labelText: "Receiver's UserID",
                        labelStyle: TextStyle(color: kBlack),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGrey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          primary: kTransparent,
                          elevation: 0,
                        ),
                        onPressed: () async {
                          bool isUserNamePresent = true;
                          final isValidForm = formKey.currentState!.validate();
                          final String userName = userIDcontroller.text;
                          final String userPhotoURL = photoURLcontroller.text;

                          for (UserDetailsModel user in state.chatlist) {
                            if (user.name == userName) {
                              isUserNamePresent = true;
                              break;
                            } else {
                              isUserNamePresent = false;
                            }
                          }
                          if (isValidForm && (isUserNamePresent == false)) {
                            await postUser(userName, userPhotoURL);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => StartChatting(userName)),
                              ),
                            );
                            BlocProvider.of<UserAPIBloc>(context).add(
                              FetchUserAPIEvent(),
                            );
                          } else {
                            existingUser(context, userName);
                          }
                        },
                        child:kStartChatting,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return kNeitherInitialNorLoadedState;
        },
      ),
    );
  }

  void existingUser(BuildContext context, String userName) {
    var alertDialog = AlertDialog(
      title: kUserAlreadyExists,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => UserAuthentication()),
              ),
            );
          },
          child: kNo,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => WhatsUpTabs(userName)),
              ),
            );
          },
          child: kYes,
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}


//IMAGE URLS:

/*  


https://images.unsplash.com/photo-1636278697183-89bd33b92cf0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGZ1bm55JTIwY2F0fGVufDB8fDB8fA%3D%3D&w=1000&q=80
https://www.gannett-cdn.com/presto/2020/06/05/PCHH/a6ef27ac-2d9c-4983-b7ef-d7ac83282656-Cat_with_Popcorn.png?width=660&height=826&fit=crop&format=pjpg&auto=webp
https://s5.favim.com/orig/69/analog-animal-black-cat-cat-Favim.com-654103.jpg
https://pittnews.com/wp-content/uploads/2017/11/Cat-Film-Festival_Courtesy-Casey-Taylor.jpg
https://images.squarespace-cdn.com/content/v1/5910d4dfe6f2e150b0706e20/1506377859725-PMTOZ4P40MKFZC1DZ99F/guesswhatanothercat.png?format=1500w
https://thumbs.dreamstime.com/b/ragdoll-cat-shot-analogue-film-portrait-nnimage-taken-full-frame-camera-140092783.jpg


*/
