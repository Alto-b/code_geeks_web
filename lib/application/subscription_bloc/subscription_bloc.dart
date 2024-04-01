import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_geeks_web/domain/booking_model.dart';
import 'package:code_geeks_web/domain/subscription_model.dart';
import 'package:code_geeks_web/domain/user_model.dart';
import 'package:code_geeks_web/infrastructure/subscription_repo.dart';
import 'package:code_geeks_web/infrastructure/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();
  UserRepo userRepo = UserRepo();
  SubscriptionBloc(this.subscriptionRepo,this.userRepo) : super(SubscriptionInitial()) {
    
    on<SubscriptionLoadEvent>(getSubsriptions);
    on<SpecificSubsLoadEvent>(getSpecificSubs);
    on<SearchSubscriptionsEvent>(searchSubscriptions);
    on<BookSubscriptionEvent>(bookSubscritpion);
    on<MySubscritpionLoadEvent>(mySubscriptions);
  }

  FutureOr<void> getSubsriptions(SubscriptionLoadEvent event, Emitter<SubscriptionState> emit)async{
    final subs = await subscriptionRepo.getSubscriptions();
    emit(SubscriptionLoadedState(subscritpionList: subs));
  }


  FutureOr<void> getSpecificSubs(SpecificSubsLoadEvent event, Emitter<SubscriptionState> emit)async {
    final specSubs = await subscriptionRepo.getSpecificSubs(event.SubsId);
    emit(SpecificSubsLoadedState(specSubsList: specSubs));
  }

  FutureOr<void> searchSubscriptions(SearchSubscriptionsEvent event, Emitter<SubscriptionState> emit)async{
    try{
      if(event.searchWord.isNotEmpty){
        final searchSubs = await subscriptionRepo.searchSubscriptions(event.searchWord);
        emit(SearchLoadedState(searchSubsList: searchSubs));
        
      }
      else{
        final subs = await subscriptionRepo.getSubscriptions();
        emit(SubscriptionLoadedState(subscritpionList: subs));
      }
    }
    catch(e){
     debugPrint("searchSubs${e.toString()}");
    }
  }

  FutureOr<void> bookSubscritpion(BookSubscriptionEvent event, Emitter<SubscriptionState> emit)async{
    try{
      await FirebaseFirestore.instance.collection("bookings")
      .doc(event.bookingId)
      .set(event.data).then((value){
        debugPrint("booking successful");
      });
    }
    on FirebaseException catch(e){
      debugPrint("bookingSubs ${e.message}");
    }
  }



  FutureOr<void> mySubscriptions(MySubscritpionLoadEvent event, Emitter<SubscriptionState> emit)async{
    subscriptionRepo.updateSubsStats();
    final mySubs = await subscriptionRepo.mySubscriptions(event.uid);
    final user = await userRepo.getUser();
    if(mySubs.isEmpty){
      emit(MySubscriptionErrorState());
    }
   else{
     emit(MySubscritpionsLoadedState(mySubsList: mySubs, userList: user,));
   }
  }
}