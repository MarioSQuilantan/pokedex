import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveLayoutUtil {
  static const int _minWidthPhone = 375;
  static const int _maxWidthPhone = 479;

  static const int _minWidthTablet = 480;
  static const int _maxWidthTablet = 1023;

  static const int _minShortestSideTablet = 600;
  static const int _maxShortestSideTablet = 1024;

  static const int _minWidthDesktop = 1024;
  static const int _maxWidthDesktop = 1799;

  static bool isPhone(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context).width;
    return (sizeScreen >= _minWidthPhone && sizeScreen <= _maxWidthPhone);
  }

  static bool isTablet(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    // final sizeScreen = mediaQuery.size.width;
    final sizeScreen = orientation == Orientation.portrait ? mediaQuery.size.width : mediaQuery.size.height;
    final shortestSide = mediaQuery.size.shortestSide;

    final bool isTabletByWidth = sizeScreen >= _minWidthTablet && sizeScreen <= _maxWidthTablet;
    final bool isTabletByShortestSide = shortestSide >= _minShortestSideTablet;
    final bool isSmallTablet = shortestSide < _maxShortestSideTablet;
    final bool isLargeTablet =
        shortestSide >= _maxShortestSideTablet &&
        (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);

    return isTabletByWidth || (isTabletByShortestSide && (isSmallTablet || isLargeTablet));
  }

  static bool isDesktop(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context).width;
    return (sizeScreen >= _minWidthDesktop && sizeScreen <= _maxWidthDesktop);
  }
}
