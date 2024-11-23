import 'package:dartz/dartz.dart';
import 'package:teast2/features/posts/domain/repositories/posts_repository.dart';
import '../../../../core/error/failures.dart';

class DeletePostsUseCase{
  final PostRepository repository;

  DeletePostsUseCase(this.repository);

  Future<Either<Failure,Unit>> call(int postId) async{
    return await repository.deletePost(postId);
  }
}