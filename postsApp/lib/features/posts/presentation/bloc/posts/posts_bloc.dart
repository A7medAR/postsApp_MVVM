import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:teast2/core/error/failures.dart';
import 'package:teast2/core/strings/failures.dart';
import 'package:teast2/features/posts/domain/entities/post.dart';
import 'package:teast2/features/posts/domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent,PostsState> {
  final GetAllPostsUserCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()){
    on<PostsEvent>((event, emit)async{
      if(event is GetAllPostsEvent){
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts.call();
       emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if(event is RefreshPostsEvent){
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts.call();
         emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState (Either<Failure, List<Post>> either){
  return  either.fold((failure)=>ErrorPostsState(
        message: _mapFailureToMessage(failure)),
          (posts) =>LoadedPostsState(posts: posts),);
  }


  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure _:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , please try again later .";
    }
  }
}