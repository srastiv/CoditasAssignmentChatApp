import 'package:chatapp/screens/tab1_start_chatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_details_bloc/user_fetch_bloc.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import 'tab2_user_status.dart';
import 'tab3_user_calls.dart';

class WhatsUpTabs extends StatelessWidget {
 String userName;
  WhatsUpTabs(this.userName);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAPIBloc, UserAPIState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "WhatsUp",
                    style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.w600,
                        fontSize: 30),
                  ),
                ),
                const SizedBox(width: 100),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kLightGreen,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: kGreen,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kLightGreen,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          color: kGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
              ],
              backgroundColor: Colors.white,
              elevation: 1,
              centerTitle: false,
              title: kWhatsUp,
              bottom: const TabBar(
                indicatorWeight: 3,
                indicatorColor: kGreen,
                labelColor: kGreen,
                unselectedLabelColor: kBlack,
                tabs: [
                  Tab(
                    text: kChats,
                  ),
                  Tab(text: kStatus),
                  Tab(text: kCalls),
                ],
                labelStyle: TextStyle(color: kBlack),
              ),
            ),
            body: TabBarView(
              children: [
                StartChatting(userName),
                const UserStatus(),
                const UserCalls(),
              ],
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kGreen, kBrightGreen],
                ),
              ),
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {},
                backgroundColor: kTransparent,
                child: const Icon(
                  Icons.chat_bubble_outline_rounded,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
