part of 'profile_setup_bloc.dart';

sealed class ProfileSetupEvent extends Equatable {
  const ProfileSetupEvent();

  @override
  List<Object> get props => [];
}

class ImageUpdateEvent extends ProfileSetupEvent{}