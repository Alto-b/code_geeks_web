import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code_geeks_web/domain/booking_model.dart';
import 'package:code_geeks_web/infrastructure/subscription_repo.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();
  HistoryBloc(this.subscriptionRepo) : super(HistoryInitial()) {
    on<HistoryLoadEvent>(loadHistory);
  }

  FutureOr<void> loadHistory(HistoryLoadEvent event, Emitter<HistoryState> emit)async{
    emit(HistoryInitial());
    Future.delayed(const Duration(seconds: 3));
    final history =await subscriptionRepo.mySubsHistory(event.uid);
    if(history.isEmpty){
      emit(HistoryEmptyState());
    }
    else{
      emit(HistoryLoadedState(historyList: history));
    }
    
  }
}
