import 'package:chatapp/bloc/message_bloc/message_bloc.dart';
import 'package:chatapp/data/user_details/get_user_api_data.dart';
import 'package:chatapp/screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_details_bloc/user_fetch_bloc.dart';
import 'constants/text_constants.dart';
import 'data/user_details/user_details_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserAPIBloc>(
          create: (BuildContext context) => UserAPIBloc(),
        ),
        BlocProvider<MessageBloc>(
          create: (BuildContext context) => MessageBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: FutureBuilder(
            future: getUserDetails(),
            builder: (context, AsyncSnapshot<List<UserDetailsModel>> snapshot) {
              if (snapshot.hasData) {
                return UserAuthentication();
                // WhatsUpTabs();
              } else if (snapshot.hasError) {
                return kSnapshotHasError;
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
