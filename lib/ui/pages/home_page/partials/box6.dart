import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:md_composer_flutter/ui/pages/home_page/home_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class box6 extends StatelessWidget {
  const box6({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: ResponsiveRowColumn(
        rowMainAxisAlignment: MainAxisAlignment.center,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: SlidingSticky(
              colorScheme: colorScheme,
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Image(
                    image: NetworkImage(
                        'https://fusetheme.com/static/assets/react/theme-layouts/layout-1-slide.png'),
                  ),
                  SizedBox(height: 24),
                  Image(
                    image: NetworkImage(
                        'https://fusetheme.com/static/assets/react/theme-layouts/layout-1-folded.png'),
                  ),
                  SizedBox(height: 24),
                  Image(
                    image: NetworkImage(
                        'https://fusetheme.com/static/assets/react/theme-layouts/layout-1-tabbed.png'),
                  ),
                  SizedBox(height: 24),
                  Image(
                    image: NetworkImage(
                        'https://fusetheme.com/static/assets/react/theme-layouts/layout-1-tabbed-dense.png'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SlidingSticky extends ConsumerWidget {
  SlidingSticky({
    Key? key,
    required this.colorScheme,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final GlobalKey k = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final renderObject = context.findRenderObject();
    final translation = renderObject?.getTransformTo(null).getTranslation();
    double offsetTop = 0;
    if (translation != null && renderObject?.paintBounds != null) {
      final offset = Offset(translation.x, translation.y);
      offsetTop = offset.dy > 0 ? 0 : (-1 * offset.dy) + 50;
      // print('offsetTop: ${offsetTop}');
    }
    double scrollpos = ref.watch(scrollProvider);
    // print('SCROLL POS: $scrollpos');

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // SizedBox(height: offsetTop),
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
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
