import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<FeedbackSentEvent>(sendFeedback);
  }

  FutureOr<void> sendFeedback(FeedbackSentEvent event, Emitter<FeedbackState> emitter)async {
    await FirebaseFirestore.instance.collection("Feedbacks")
    .doc()
    .set(event.data);
  }
}
