import 'package:dartz/dartz.dart';
import 'package:teast2/features/posts/domain/repositories/posts_repository.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUserCase{
  final PostRepository repository;

  GetAllPostsUserCase(this.repository);

  Future<Either<Failure,List<Post>>> call() async{
    return await repository.getAllPosts();
  }
}