import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:md_composer_flutter/providers/color_scheme_provider.dart';
import 'package:md_composer_flutter/ui/pages/typography_page/typografy_provider.dart';
import 'package:text_editor/text_editor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:markdown/markdown.dart' as md;

class TypographyPage extends ConsumerWidget {
  const TypographyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = ref.watch(colorSchemeProvider);
    final example = ref.watch(typographyProvider);
    return ListView(
      padding: EdgeInsets.all(24),
      controller: ScrollController(),
      children: [
        DropdownButton(
          value: example,
          items: [
            'Markdown',
            'HTML',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            ref.read(typographyProvider.notifier).state = value.toString();
          },
        ),
        if (example == 'Markdown') exampleMarkdown(colorScheme: colorScheme),
        if (example == 'HTML') const exampleHTML()
      ],
    );
  }
}

class exampleHTML extends StatelessWidget {
  const exampleHTML({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Using HTML',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        FutureBuilder(
          future: rootBundle.loadString("assets/htmlTypography.html"),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return HtmlWidget(
                snapshot.data.toString(),
              );
            }
            return Text('NO DATA');
          },
        ),
      ],
    );
  }
}

class exampleMarkdown extends StatelessWidget {
  const exampleMarkdown({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Using Markdown',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        FutureBuilder(
          future: rootBundle.loadString("assets/markDownExample.md"),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return MarkdownBody(
                data: snapshot.data.toString(),
                onTapLink: (text, href, title) {
                  href != null ? launchUrl(Uri.parse(href)) : null;
                },
                styleSheet: MarkdownStyleSheet(
                    codeblockDecoration: BoxDecoration(
                      color: colorScheme.inverseSurface,
                    ),
                    code: TextStyle(
                        backgroundColor: colorScheme.inverseSurface,
                        color: colorScheme.onInverseSurface)),
                selectable: true,
                extensionSet: md.ExtensionSet(
                  md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                  [
                    md.EmojiSyntax(),
                    // ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                  ],
                ),
                fitContent: true,
              );
            }
            return const Text('NO DATA');
          },
        ),
      ],
    );
  }
}
