import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'join_mentor_event.dart';
part 'join_mentor_state.dart';

class JoinMentorBloc extends Bloc<JoinMentorEvent, JoinMentorState> {
  JoinMentorBloc() : super(JoinMentorInitial()) {
    on<FilePickerInitialEvent>((event, emit) {
      emit(JoinMentorInitial());
    },);
    on<FilePickerEvent>(pickFile); 
    on<PlaceRequestEvent>(requestToFirebase);

  }

  FutureOr<void> pickFile(FilePickerEvent event, Emitter<JoinMentorState> emit)async{
     Uint8List? file =await ImagePickerWeb.getImageAsBytes();
        emit(FilePickedState(filePath: file!));
       }

  FutureOr<void> requestToFirebase(PlaceRequestEvent event, Emitter<JoinMentorState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("join_mentors")
      .doc(event.reqId)
      .set(event.data).then((value){
        debugPrint("MentorRequest successful");
      });
    }
    on FirebaseException catch(e){
      debugPrint("MentorRequest failed ${e.message}");
    }
  }
}
