part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();
  
  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

class HistoryEmptyState extends HistoryState{}

class HistoryLoadedState extends HistoryState{
  final List<BookingModel> historyList;
  const HistoryLoadedState({
    required this.historyList
  });
  @override
  List<Object> get props => [historyList];
}
