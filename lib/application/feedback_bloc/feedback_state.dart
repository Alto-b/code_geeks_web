part of 'feedback_bloc.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();
  
  @override
  List<Object> get props => [];
}

final class FeedbackInitial extends FeedbackState {}

class FeedbackSendState extends FeedbackState{}
