part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}
//homepage states
class HomeInitial extends HomeState {}

class HomePageLoadingState extends HomeState{}

class HomePageLoadedState extends HomeState{}

class HomePageErrorState extends HomeState{}

//language states
class LanguageLoadingState extends HomeState{
  // get languageList => null;
}
class LanguageLoadedState extends HomeState{
  final List<LanguageModel> languageList;
  const LanguageLoadedState({required this.languageList});
}

class LanguageErrorState extends HomeState{}

//mentor states
class MentorLoadingState extends HomeState{}

class MentorLoadedState extends HomeState{
  final List<MentorModel> mentorList;
  const MentorLoadedState({required this.mentorList});
}

class MentorErrorState extends HomeState{}


//loading all contents
class HomeContentLoadedState extends HomeState {
  final List<LanguageModel> languageList;
  final List<MentorModel> mentorList;

  const HomeContentLoadedState(this.languageList, this.mentorList);
}