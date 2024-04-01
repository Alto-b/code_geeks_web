part of 'profile_setup_bloc.dart';

sealed class ProfileSetupState extends Equatable {
  const ProfileSetupState();
  
  @override
  List<Object> get props => [];
}

final class ProfileSetupInitial extends ProfileSetupState {}

class ImageUpdateState extends ProfileSetupState{
  final Uint8List imageFile;
  ImageUpdateState({
    required this.imageFile
  });
  @override
  List<Object> get props => [imageFile];
}
