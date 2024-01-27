import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

part 'image_names.dart';

class ImageHelper {
  static const String _pathToImageAssets = 'assets';

  static Widget getSvg(
    String name, {
    Color? color,
    double? width,
    double? height,
  }) {
    try {
      return SvgPicture.asset(
        '$_pathToImageAssets/icons/$name.svg',
        color: color,
        width: width,
        height: height,
      );
    } catch (e) {
      return Container();
    }
  }

  static Image getImage(String name, {double? width, double? height, BoxFit? fit}) {
    return Image(
      width: width,
      height: height,
      image: AssetImage('$_pathToImageAssets/images/$name.png'),
      fit: fit,
    );
  }
}
