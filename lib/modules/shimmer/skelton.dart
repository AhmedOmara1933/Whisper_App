import 'package:flutter/material.dart';

class Skelton extends StatelessWidget {
  final bool isCircle;
  final double ?height;
  final double ?width;

  const Skelton(
      {super.key,
      this.isCircle = false,
       this.height,
       this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      height: height,
      width: width,
      decoration: isCircle
          ? BoxDecoration(
              color: Colors.black.withOpacity(0.09), shape: BoxShape.circle)
          : BoxDecoration(
              color: Colors.black.withOpacity(0.09),
              borderRadius: BorderRadius.circular(10.0),
            ),
    );
  }
}
