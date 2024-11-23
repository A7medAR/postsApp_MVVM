import 'package:dartz/dartz.dart';
import 'package:teast2/core/error/exception.dart';
import 'package:teast2/core/error/failures.dart';
import 'package:teast2/core/network/network_info.dart';
import 'package:teast2/features/posts/data/models/post_model.dart';
import 'package:teast2/features/posts/domain/entities/post.dart';
import 'package:teast2/features/posts/domain/repositories/posts_repository.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';


typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();


class PostsRepositoryImpl implements PostRepository{

  final PostRemoteDataSource remoteDateSource;
  final PostLocalDataSource localDateSource;
  final NetWorkInfo netWorkInfo;

  PostsRepositoryImpl( {required this.remoteDateSource,
    required this.localDateSource,required this.netWorkInfo,});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    if(await netWorkInfo.isConnected){
      try {
       final remotePosts= await remoteDateSource.getAllPosts();
       localDateSource.cachedPosts(remotePosts);
       return Right(remotePosts);

      }on ServerException{
        return Left(ServerFailure());
      }
    }else {
      try{
        final localPosts=   await localDateSource.getCachedPosts();
        return Right(localPosts);
      }on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
  final PostModel postModel=PostModel(title: post.title, body: post.body);

  return await _getMessage((){
    return remoteDateSource.addPost(postModel);
  });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async{
    return await _getMessage((){
      return remoteDateSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async{
    final PostModel postModel=PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage((){
      return remoteDateSource.updatePost(postModel);
    });
  }



  Future<Either<Failure, Unit>>_getMessage(
    DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async{
    if(await netWorkInfo.isConnected){
      try{
       await deleteOrUpdateOrAddPost();
        return const Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
  }
}