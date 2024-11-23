part of 'add_delete_update_posts_bloc.dart';


abstract class AddDeleteUpdatePostsState extends Equatable{
  const AddDeleteUpdatePostsState();

  @override
  List<Object> get props =>[];

}

class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState{}

class LoadingAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState{}

class MessageAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState{

  final String message;

  const MessageAddDeleteUpdatePostsState({required this.message});

  @override
  List<Object> get props =>[message];
}

class ErrorAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState{

  final String message;

  const ErrorAddDeleteUpdatePostsState({required this.message});

  @override
  List<Object> get props =>[message];
}