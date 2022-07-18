import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class GalleryItem {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const GalleryItem(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  static GalleryItem fromJson(json) => GalleryItem(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
      );
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<GalleryItem> galleryItems = [];

  final url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
  @override
  void initState() {
    super.initState();
    getItemsFromAPI();
  }

  getItemsFromAPI() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      setState(() {
        galleryItems = items.map<GalleryItem>(GalleryItem.fromJson).toList();
      });
    }
  }

  int thumbnailSize = 150;
  int imageSize = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (constraints.maxWidth / thumbnailSize).floor(),
              crossAxisSpacing: 5),
          padding: EdgeInsets.all(16),
          controller: ScrollController(),
          itemCount: galleryItems.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              // margin: EdgeInsets.only(bottom: 10),
              child: Hero(
                tag: galleryItems[index].id,
                child: Material(
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context)
                          .go('/gallery_detail', extra: galleryItems[index]);
                    },
                    child: Image(image: NetworkImage(galleryItems[index].url)),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
