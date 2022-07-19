import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:md_composer_flutter/ui/pages/api_contents/gallery_page.dart';
import 'package:md_composer_flutter/utils/functions.dart';

class GalleryDetailPage extends StatelessWidget {
  final double timeDilation = 5.0;
  final GalleryItem galleryItem;
  const GalleryDetailPage({Key? key, required this.galleryItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: InkWell(
      //     child: const Icon(Icons.arrow_back),
      //     onTap: () {
      //       if (GoRouter.of(context).canPop()) {
      //         GoRouter.of(context).pop();
      //         return;
      //       }
      //       GoRouter.of(context).push('/gallery');
      //     },
      //   ),
      //   title: Text(capitalize(galleryItem.title)),
      // ),
      body: Center(
        child: Hero(
          tag: galleryItem.id,
          child: Material(
            child: InkWell(
              onTap: () {
                print('CAN POP: ${context.canPop()}');
                if (GoRouter.of(context).canPop()) {
                  GoRouter.of(context).pop();
                  return;
                }
                context.pop();
                // GoRouter.of(context).push('/gallery');
              },
              child: Image(
                image: NetworkImage(galleryItem.url),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
