import 'package:flutter/material.dart';

class box1 extends StatelessWidget {
  const box1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // transform: Matrix4.translationValues(0.0, -150.0, 0.0),
      child: Column(
        children: const [
          Center(
            child: Text('Lorem ipsum dolor sit amet...',
                style: TextStyle(fontSize: 24)),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
