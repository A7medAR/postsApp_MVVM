import 'package:flutter/material.dart';
import 'package:teast2/features/posts/domain/entities/post.dart';

import '../../pages/post_detail_page.dart';

class PostListWidget extends StatelessWidget {
 final List<Post>posts;
  const PostListWidget({
    super.key,
    required this.posts,

  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index){
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title:Text(posts[index].title,
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),),
          subtitle:Text(posts[index].body,
            style: const TextStyle(fontSize: 16,),),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>PostDetailPage(post: posts[index],)));
          },
        );
      },
      separatorBuilder: (context,index)=>const Divider(thickness: 1,),
      itemCount: posts.length,


    );
  }
}
