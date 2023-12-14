// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageLoader {
  ImageLoader._();

  static Image image(
    String path, {
    Key? key,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
    double? size,
    Color? color,
  }) {
    return Image(
      key: key,
      image: AssetImage('assets/images/$path.png'),
      fit: fit,
      width: size ?? width,
      height: size ?? height,
      color: color,
    );
  }

  static Image gif(
    String fileName, {
    Key? key,
    BoxFit fit = BoxFit.contain,
    double? size,
    Color? color,
  }) {
    return Image.asset(
      'assets/gif/$fileName.gif',
      width: size,
      height: size,
    );
  }
}
