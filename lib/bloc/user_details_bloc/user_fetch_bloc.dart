import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:chatapp/data/user_details/get_user_api_data.dart';
import 'package:chatapp/data/user_details/user_details_model.dart';
part 'user_fetch_event.dart';
part 'user_fetch_state.dart';

class UserAPIBloc extends Bloc<UserAPIEvent, UserAPIState> {
  UserAPIBloc() : super(InitialUserAPIState()) {
    on<FetchUserAPIEvent>((event, emit) async {
      var userDetails = await getUserDetails();
     // print("USER BODY IN BLOC - USER-API-FETCH: ${userDetails.toString()}");
      emit(
        LoadedUserAPIState(chatlist: userDetails),
      );
    });
  }
}
