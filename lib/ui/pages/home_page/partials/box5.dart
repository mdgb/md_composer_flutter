import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class box5 extends StatelessWidget {
  const box5({
    Key? key,
    required this.colorScheme,
    required this.markdownContent3,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final String markdownContent3;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        width: ResponsiveWrapper.of(context).isLargerThan(DESKTOP)
            ? MediaQuery.of(context).size.width / 2
            : null,
        child: Column(
          children: [
            Icon(
              Icons.amp_stories_rounded,
              color: colorScheme.primary,
              size: 80,
            ),
            const Text(
              'Multiple layouts & themes',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text('Setting up a page layout is a breeze with Fuse React.'),
            const SizedBox(height: 24),
            MarkdownBody(
              data: markdownContent3,
              onTapLink: (text, href, title) {
                href != null ? launchUrl(Uri.parse(href)) : null;
              },
              styleSheet:
                  MarkdownStyleSheet(textAlign: WrapAlignment.spaceEvenly),
            ),
            const SizedBox(height: 24),
            const Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/video/layout.gif'),
            ),
          ],
        ),
      ),
    );
  }
}
