import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class box4 extends StatelessWidget {
  const box4({
    Key? key,
    required this.colorScheme,
    required this.markdownContent2,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final String markdownContent2;

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumn(
      rowMainAxisAlignment: MainAxisAlignment.center,
      layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
          ? ResponsiveRowColumnType.COLUMN
          : ResponsiveRowColumnType.ROW,
      rowTextDirection: TextDirection.rtl,
      children: [
        ResponsiveRowColumnItem(
          rowFlex: 1,
          child: Container(
            padding: const EdgeInsets.all(32),
            // color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 80,
                  // height: 80,
                  // child: Icon(
                  //   Icons.book,
                  //   color: colorScheme.primary,
                  //   size: 80,
                  // ),
                  child:
                      Lottie.asset('assets/lottie/74945-paper-airplane.json'),
                ),
                MarkdownBody(
                  data: markdownContent2,
                  onTapLink: (text, href, title) {
                    href != null ? launchUrl(Uri.parse(href)) : null;
                  },
                ),
              ],
            ),
          ),
        ),
        ResponsiveRowColumnItem(
          rowFlex: 1,
          child: Container(
            padding: const EdgeInsets.all(32),
            child: const Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://fusetheme.com/static/assets/react/learning-source.png'),
            ),
          ),
        ),
      ],
    );
  }
}
