part of 'user_fetch_bloc.dart';

@immutable
abstract class UserAPIState {}

class InitialUserAPIState extends UserAPIState {}

class LoadedUserAPIState extends UserAPIState {
  final List<UserDetailsModel> chatlist;
  UserDetailsModel? chatlistElement;
  LoadedUserAPIState({required this.chatlist, this.chatlistElement});
}

class ErrorUserAPIState extends UserAPIState {
  final error;
  ErrorUserAPIState({this.error});
}
