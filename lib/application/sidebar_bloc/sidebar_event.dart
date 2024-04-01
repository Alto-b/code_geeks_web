part of 'sidebar_bloc.dart';

sealed class SidebarEvent extends Equatable {
  const SidebarEvent();

  @override
  List<Object> get props => [];
}

class IndexChangeEvent extends SidebarEvent{
  final int index;
  IndexChangeEvent({required this.index});
}
