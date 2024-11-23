import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teast2/core/widgets/loading_widget.dart';
import 'package:teast2/features/posts/domain/entities/post.dart';
import 'package:teast2/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:teast2/features/posts/presentation/pages/posts_pages.dart';

import '../../../../core/util/snackbarmessage.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_buildAppbar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar(){
    return AppBar(
      title: Text(isUpdatePost? "Edit Post" :"Add Post"),
    );
  }

  Widget _buildBody(BuildContext context){
    return Center(
      child: Padding(padding: const EdgeInsets.all(10),
      child:BlocConsumer<AddDeleteUpdatePostsBloc,AddDeleteUpdatePostsState>(
        listener:(context,state){
          if(state is MessageAddDeleteUpdatePostsState){
            SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_)=>const PostsPages()),
                (route)=>false);
          }
          else if(state is ErrorAddDeleteUpdatePostsState){
            SnackBarMessage().showErrorSnackBar(message: state.message, context: context);

          }
        },
          builder: (context,state){
          if(state is LoadingAddDeleteUpdatePostsState){
            return const LoadingWidget();
          }
          return FormWidget(
            isUpdatePost:isUpdatePost,post: isUpdatePost ? post:null,);
          },

      ) ,
      ),
    );
  }

}
