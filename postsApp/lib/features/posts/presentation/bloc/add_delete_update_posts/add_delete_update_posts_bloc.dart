import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:teast2/core/error/failures.dart';
import 'package:teast2/core/strings/failures.dart';
import 'package:teast2/core/strings/messages.dart';
import 'package:teast2/features/posts/domain/entities/post.dart';
import 'package:teast2/features/posts/domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_update_posts_event.dart';
part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc extends Bloc<AddDeleteUpdatePostsEvent,AddDeleteUpdatePostsState> {

  final AddPostUseCase addPosts;
  final UpdatePostUseCase updatePosts;
  final DeletePostsUseCase deletePosts;
  AddDeleteUpdatePostsBloc( {required this.addPosts,required this.updatePosts,required this.deletePosts,}) : super(AddDeleteUpdatePostsInitial()){
    on<AddDeleteUpdatePostsEvent>((event, emit)async{
      if(event is AddPostsEvent){

        emit(LoadingAddDeleteUpdatePostsState());
        final failureOrDoneMessage = await addPosts(event.post);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage,ADD_SUCCESS_MESSAGE));

      } else if(event is UpdatePostsEvent){
        emit(LoadingAddDeleteUpdatePostsState());
        final failureOrDoneMessage = await updatePosts(event.post);

        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage,UPDATE_SUCCESS_MESSAGE));

      }else if(event is DeletePostsEvent){
        emit(LoadingAddDeleteUpdatePostsState());
        final failureOrDoneMessage = await deletePosts(event.postId);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage,DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostsState _eitherDoneMessageOrErrorState(Either<Failure, Unit>either, String message){

    return either.fold((failure)=>ErrorAddDeleteUpdatePostsState(message: _mapFailureToMessage(failure)),
            (_)=>MessageAddDeleteUpdatePostsState(message:message),
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , please try again later .";
    }
  }

}


