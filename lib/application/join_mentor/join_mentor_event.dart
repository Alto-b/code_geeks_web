// ignore_for_file: must_be_immutable

part of 'join_mentor_bloc.dart';

 class JoinMentorEvent extends Equatable {
  const JoinMentorEvent();

  @override
  List<Object> get props => [];
}

class FilePickerInitialEvent extends JoinMentorEvent{}
class FilePickerEvent extends JoinMentorEvent{}

class PlaceRequestEvent extends JoinMentorEvent{
  Map<String,dynamic> data = {};
  String reqId;
  PlaceRequestEvent({
    required this.data,
    required this.reqId
  });
 }

