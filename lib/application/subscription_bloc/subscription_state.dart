part of 'subscription_bloc.dart';

 class SubscriptionState extends Equatable {
  const SubscriptionState();
  
  @override
  List<Object> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoadingState extends SubscriptionState{}

class SubscriptionLoadedState extends SubscriptionState{
  final List<SubscriptionModel> subscritpionList;

  const SubscriptionLoadedState({
    required this.subscritpionList
  });
}

class SpecificSubsLoadedState extends SubscriptionState{
  final List<SubscriptionModel> specSubsList;
  const SpecificSubsLoadedState({
    required this.specSubsList
  });
  @override
  List<Object> get props => [specSubsList];
}

class SearchLoadedState extends SubscriptionState{
  final List<SubscriptionModel> searchSubsList;
  const SearchLoadedState({
    required this.searchSubsList
  });
  @override
  List<Object> get props => [searchSubsList];
}

class MySubscriptionErrorState extends SubscriptionState{}

class MySubscritpionsLoadedState  extends SubscriptionState{
  final List<BookingModel> mySubsList;
  // final List<SubscriptionModel> subsList;
  final UserModel userList;

  const MySubscritpionsLoadedState({
    required this.mySubsList,
    // required this.subsList,
    required this.userList
  });
  @override
  List<Object> get props => [mySubsList,userList];
}