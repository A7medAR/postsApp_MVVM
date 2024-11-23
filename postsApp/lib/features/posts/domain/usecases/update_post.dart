import 'package:dartz/dartz.dart';
import 'package:teast2/features/posts/domain/entities/post.dart';
import 'package:teast2/features/posts/domain/repositories/posts_repository.dart';
import '../../../../core/error/failures.dart';

class UpdatePostUseCase{
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure,Unit>> call(Post post) async{
    return await repository.updatePost(post);
  }
}