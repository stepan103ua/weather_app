import 'package:flutter/material.dart';

class FittedText extends StatelessWidget {
  const FittedText(
      {Key? key,
      required this.title,
      required this.height,
      required this.style})
      : super(key: key);
  final String title;
  final double height;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}
