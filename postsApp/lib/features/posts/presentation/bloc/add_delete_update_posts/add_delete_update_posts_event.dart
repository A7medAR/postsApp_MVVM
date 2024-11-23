part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsEvent extends Equatable{
  const AddDeleteUpdatePostsEvent();

  @override
  List<Object> get props =>[];
}

class AddPostsEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  const AddPostsEvent({required this.post});

  @override
  List<Object> get props =>[post];
}

class UpdatePostsEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  const UpdatePostsEvent({required this.post});
  @override
  List<Object> get props =>[post];
}

class DeletePostsEvent extends AddDeleteUpdatePostsEvent{
  final int postId;

  const DeletePostsEvent({required this.postId});

  @override
  List<Object> get props =>[postId];
}