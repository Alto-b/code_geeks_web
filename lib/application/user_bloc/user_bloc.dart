import 'package:bloc/bloc.dart';
import 'package:code_geeks_web/domain/user_model.dart';
import 'package:code_geeks_web/infrastructure/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  // final FireStoreServices _fireStoreServices;

  User? user = FirebaseAuth.instance.currentUser;

  UserRepo userRepo = UserRepo();

  UserBloc(this.userRepo) : super(UserInitialState()) {

    on<LoadUserEvent>((event, emit)async {
    emit(UserLoadingState());
      await Future.delayed(const Duration(seconds: 1));
    try{
      final data = await userRepo.getUser();
      emit(UserLoadedState(userList:data ));
    }
    on FirebaseException catch(e){
      emit(UserErroState(errorMessage: "error loading user data ${e.message}"));
    }

     });


    
  }
}
