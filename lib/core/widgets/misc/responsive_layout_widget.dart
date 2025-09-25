import 'package:flutter/material.dart';

import '../../core.dart';

class ResponsiveLayoutWidget extends StatelessWidget {
  final Widget mobileView;
  final Widget desktopView;
  final Widget tabletView;
  final bool isLoading;

  const ResponsiveLayoutWidget({
    super.key,
    required this.mobileView,
    required this.desktopView,
    required this.tabletView,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveLayoutUtil.isDesktop(context)) {
          return LoadingStackWidget(isLoading: isLoading, child: desktopView);
        }

        if (ResponsiveLayoutUtil.isTablet(context)) {
          return LoadingStackWidget(isLoading: isLoading, child: tabletView);
        }

        return LoadingStackWidget(isLoading: isLoading, child: mobileView);
      },
    );
  }
}
