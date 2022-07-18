import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:md_composer_flutter/utils/functions.dart';

class StickyBox extends StatelessWidget {
  const StickyBox({Key? key}) : super(key: key);

  final int blocks = 30;
  final int sticky_box_index = 3;
  final double boxHeight = 250;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: ScrollController(), slivers: [
      ...List<int>.generate(sticky_box_index, (index) => index)
          .asMap()
          .entries
          .map(
            ((e) => SliverToBoxAdapter(
                  child: Container(
                    height: boxHeight,
                    color: getRandomColor(),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('TEXT ${e.key}'),
                  ),
                )),
          ),
      StickySliver(
        child: Container(
          height: boxHeight,
          color: Colors.black,
        ),
      ),
      ...List<int>.generate(blocks - sticky_box_index, (index) => index)
          .asMap()
          .entries
          .map(
            ((e) => SliverToBoxAdapter(
                  child: Container(
                    height: boxHeight,
                    color: getRandomColor(),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('TEXT ${e.key}'),
                  ),
                )),
          ),
      SliverToBoxAdapter(child: SizedBox(height: boxHeight)),
    ]);
  }
}

class StickySliver extends SingleChildRenderObjectWidget {
  const StickySliver({Widget? child, Key? key}) : super(child: child, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderStickySliver();
  }
}

class RenderStickySliver extends RenderSliverToBoxAdapter {
  RenderStickySliver({RenderBox? child}) : super(child: child);

  @override
  void performLayout() {
    var myCurrentContraints = constraints;
    // print("myCurrentContraints $myCurrentContraints");
    geometry = SliverGeometry.zero;

    child?.layout(
      constraints.asBoxConstraints(),
      parentUsesSize: true,
    );

    double childExtent = child?.size.height ?? 0;

    // print(constraints.remainingPaintExtent);
    // print(childExtent);
    geometry = SliverGeometry(
      paintExtent: constraints.remainingPaintExtent < childExtent
          ? constraints.remainingPaintExtent
          : childExtent,
      maxPaintExtent: childExtent,
      paintOrigin: constraints.scrollOffset,
    );

    setChildParentData(child!, constraints, geometry!);
  }
}
