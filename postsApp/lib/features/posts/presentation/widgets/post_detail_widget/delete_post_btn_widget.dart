import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snackbarmessage.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import '../../pages/posts_pages.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
      onPressed: ()=> deleteDialog(context,postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context,int postId){
    showDialog(context: context,
        builder: (context){
          return  BlocConsumer<AddDeleteUpdatePostsBloc,AddDeleteUpdatePostsState>(
            listener: (context,state){
              if(state is MessageAddDeleteUpdatePostsState){
                SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>const PostsPages()),
                        (route)=>false);
              }else if(state is ErrorAddDeleteUpdatePostsState){
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
              }
            },
            builder: (context,state){
              if (state is LoadingAddDeleteUpdatePostsState){
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId:postId);
            },
          );
        }
    );

  }
}
