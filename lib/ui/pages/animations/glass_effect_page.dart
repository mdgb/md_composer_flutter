import 'dart:ui';

import 'package:flutter/material.dart';

class GlassEffectPage extends StatefulWidget {
  const GlassEffectPage({Key? key}) : super(key: key);

  @override
  State<GlassEffectPage> createState() => _GlassEffectPageState();
}

class _GlassEffectPageState extends State<GlassEffectPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image:
              NetworkImage('https://cdn.wallpapersafari.com/35/50/0QHTmB.jpg'),
        ),
      ),
      child: GlassEffectContainer(
          child: Center(
              child: Text(
        'Glass',
        style: TextStyle(
            fontSize: 65,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.bold),
      ))),
    );
  }
}

class GlassEffectContainer extends StatefulWidget {
  final Widget? child;
  const GlassEffectContainer({Key? key, this.child}) : super(key: key);

  @override
  State<GlassEffectContainer> createState() => _GlassEffectContainerState();
}

class _GlassEffectContainerState extends State<GlassEffectContainer> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      widthFactor: 0.6,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: Colors.white30),
              // color: Colors.white.withOpacity(0.1),
              // image: const DecorationImage(
              //   image: NetworkImage(
              //       'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/1177d997-54a5-47ed-8309-eb5d0285890a/ddyr6zj-5e446f66-7365-4384-ab56-044682d4c721.png/v1/fill/w_1280,h_854,strp/broken_glass_png_28_by_agusrockforlife_ddyr6zj-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9ODU0IiwicGF0aCI6IlwvZlwvMTE3N2Q5OTctNTRhNS00N2VkLTgzMDktZWI1ZDAyODU4OTBhXC9kZHlyNnpqLTVlNDQ2ZjY2LTczNjUtNDM4NC1hYjU2LTA0NDY4MmQ0YzcyMS5wbmciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.9FHULnk8FT9lBfWIJy0rTPoUoMCWLP4pQ-BFEM5aerg'),
              //   fit: BoxFit.cover,
              //   opacity: 0.5,
              // ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.4)
                ],
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
