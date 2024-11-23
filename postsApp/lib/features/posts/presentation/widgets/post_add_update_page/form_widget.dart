import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teast2/features/posts/domain/entities/post.dart';
import 'package:teast2/features/posts/presentation/bloc/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:teast2/features/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart';

import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
 final Post? post;
 final bool isUpdatePost;
  const FormWidget({super.key, this.post, required this.isUpdatePost});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController=TextEditingController();
  TextEditingController _bodyController=TextEditingController();
  @override
  void initState(){
    super.initState();
    if(widget.isUpdatePost){
      _titleController.text=widget.post!.title;
      _bodyController.text=widget.post!.body;
    }
  }
void  validateFormThenUpdateOrAddPost(){
    final isValid=_formKey.currentState!.validate();
    if(isValid){
      final post=Post(id: widget.isUpdatePost?widget.post!.id:null,
          title: _titleController.text,
          body: _bodyController.text);
      if(widget.isUpdatePost){
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(UpdatePostsEvent(post: post));
      }else{
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(AddPostsEvent(post: post));

      }
    }
}
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(name:"Title",multiLines:false,controller:_titleController),
            TextFormFieldWidget(name:"Body",multiLines:true,controller:_bodyController),
            FormSubmitBtn(isUpdatePost:widget.isUpdatePost,onPressed:validateFormThenUpdateOrAddPost),



          ],
        ),
    );
  }
}

