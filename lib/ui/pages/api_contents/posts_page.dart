import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:md_composer_flutter/utils/functions.dart';

class Posts extends StatefulWidget {
  Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<dynamic> posts = [];

  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  @override
  void initState() {
    super.initState();
    print('INIT STATE');
    getPostsFromAPI();
  }

  getPostsFromAPI() async {
    print('INSIDE ASYNC');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      setState(() {
        posts = items;
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
                    title:
                        Text(capitalize(posts[i]['title']?.toString() ?? '  ')),
                    subtitle:
                        Text(capitalize(posts[i]['body']?.toString() ?? '  ')),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
