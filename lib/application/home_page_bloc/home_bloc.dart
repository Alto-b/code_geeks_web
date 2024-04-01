import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_web/domain/language_model.dart';
import 'package:code_geeks_web/domain/mentor_model.dart';
import 'package:code_geeks_web/infrastructure/language_repo.dart';
import 'package:code_geeks_web/infrastructure/mentor_repo.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  LanguageRepo langrep = LanguageRepo();
  MentorRepo mentorRepo = MentorRepo();
  HomeBloc(this.langrep,this.mentorRepo) : super(HomePageLoadingState()) {
    on<HomeLoadingEvent>(loadingHome);
  }

  

  FutureOr<void> loadingHome(HomeLoadingEvent event, Emitter<HomeState> emit)async{
    emit(HomePageLoadingState());
    final lang =await langrep.getlanguage();
    emit(LanguageLoadedState(languageList: lang));
    final mentor = await mentorRepo.getMentor();
    emit(MentorLoadedState(mentorList: mentor));
     emit(HomeContentLoadedState(lang, mentor));
  }
}
