part of 'post_bloc.dart';

 class PostState extends Equatable {
  const PostState();
  
  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class FeedLoadedState extends PostState{
  final List<PostModel> postList;
  const FeedLoadedState({
    required this.postList
  });
  @override
  List<Object> get props => [postList];
}
