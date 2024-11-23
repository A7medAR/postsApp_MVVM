import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teast2/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: const Text("NO",),),
        TextButton(onPressed: (){
          BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(DeletePostsEvent(postId: postId,),);
        }, child: const Text("Yes",),)

      ],
    );
  }
}
