import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:md_composer_flutter/utils/functions.dart';

class Post {
  final String title;
  final String body;

  const Post({
    required this.title,
    required this.body,
  });

  static Post fromJson(json) => Post(
        title: json['title'],
        body: json['body'],
      );
}

class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Post> posts = [];

  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  @override
  void initState() {
    super.initState();
    getPostsFromAPI();
  }

  getPostsFromAPI() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      setState(() {
        posts = items.map<Post>(Post.fromJson).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      controller: ScrollController(),
      children: [
        for (var i = 0; i < posts.length; i++)
          Container(
            child: Card(
              elevation: 10,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(10),
                    dense: false,
                    title: Text(capitalize(posts[i].title.toString())),
                    subtitle: Text(capitalize(posts[i].body.toString())),
                    trailing: Icon(Icons.arrow_circle_right),
                    onTap: () {
                      GoRouter.of(context).go('/post_detail', extra: posts[i]);
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
