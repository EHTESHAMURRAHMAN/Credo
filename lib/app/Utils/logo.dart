import 'package:flutter/material.dart';

class LogoBuilder extends StatelessWidget {
  double height;
  double width;
  final String img;
  LogoBuilder({
    super.key,
    required this.img,
    this.height = 40.0,
    this.width = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon/${img.toLowerCase()}@2x.png',
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
    );
  }
}
