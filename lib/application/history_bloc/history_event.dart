part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class HistoryLoadEvent extends HistoryEvent{
  String uid;
  HistoryLoadEvent({
    required this.uid
  }); 
}
