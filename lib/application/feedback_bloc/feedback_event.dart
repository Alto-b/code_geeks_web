// ignore_for_file: must_be_immutable

part of 'feedback_bloc.dart';

sealed class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class FeedbackSentEvent extends FeedbackEvent{
  Map<String,String?> data={};
 FeedbackSentEvent({required this.data});

 @override
  List<Object> get props => [data];
}
