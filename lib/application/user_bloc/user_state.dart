part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

final class UserInitialState extends UserState {}

class UserLoadingState extends UserState{
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState{

  final UserModel userList;

  const UserLoadedState({required this.userList});
  @override
  List<Object> get props => [userList];
}

class UserSuccessState extends UserState{
  final String message;
  const UserSuccessState({required this.message});
}

class UserErroState extends UserState{
  final String errorMessage;
  const UserErroState({required this.errorMessage});
}
