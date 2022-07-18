import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/posts_page.dart';
import 'package:md_composer_flutter/utils/functions.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
              return;
            }
            GoRouter.of(context).go('/posts');
          },
        ),
        title: Text(capitalize(post.title)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Text(post.body),
      ),
    );
  }
}
