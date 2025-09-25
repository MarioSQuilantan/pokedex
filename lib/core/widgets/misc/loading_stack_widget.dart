import 'package:flutter/material.dart';

class LoadingStackWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingStackWidget({super.key, required this.child, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) ...[
          Positioned.fill(child: Container(color: Colors.black.withAlpha((0.8 * 255).toInt()))),
          Center(child: CircularProgressIndicator()),
        ],
      ],
    );
  }
}
