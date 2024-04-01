part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}
 
class HomeLoadingEvent extends HomeEvent{}

class HomePageLoadedEvent extends HomeEvent{}

class HomePageErrorEvent extends HomeEvent{}

class LanguageLoadEvent extends HomeEvent{}

class MentorLoadEvent extends HomeEvent{}