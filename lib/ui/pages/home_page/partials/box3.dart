import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class box3 extends StatelessWidget {
  const box3({
    Key? key,
    required this.colorScheme,
    required this.markdownContent,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final String markdownContent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: ClipPath(
            clipper: BackgroundClipper2(),
            child: Container(
              width: double.infinity,
              // height: double.minPositive,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(248, 250, 252, 0),
                    Color.fromRGBO(226, 232, 240, 100),
                  ],
                ),
              ),
              child: Container(),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 50),
          child: ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
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
                        child: Icon(
                          Icons.rocket_launch,
                          color: colorScheme.primary,
                          size: 80,
                        ),
                      ),
                      MarkdownBody(
                        data: markdownContent,
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
                        'https://fusetheme.com/static/assets/react/dashboards/project-dashboard.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BackgroundClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 250);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height + 250,
      size.width,
      size.height - 250,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
