import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../widgets/post_detail_widget/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    return Center(
      child: Padding(padding: const EdgeInsets.all(10),
      child:PostDetailWidget(post: post),
      ),
    );
  }
}
