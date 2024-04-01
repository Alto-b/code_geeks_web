import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

part 'profile_setup_event.dart';
part 'profile_setup_state.dart';


class ProfileSetupBloc extends Bloc<ProfileSetupEvent, ProfileSetupState> {
  ProfileSetupBloc() : super(ProfileSetupInitial()) {
    on<ImageUpdateEvent>(updateImage);
  }

  FutureOr<void> updateImage(ImageUpdateEvent event, Emitter<ProfileSetupState> emit)async {
    try{
     Uint8List? file =await ImagePickerWeb.getImageAsBytes();
    emit(ImageUpdateState(imageFile: file!));
    }catch(e){
      debugPrint("Exception occured while picking profile image $e");
    }
  }
}
