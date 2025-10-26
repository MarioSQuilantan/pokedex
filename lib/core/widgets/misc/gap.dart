import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../core.dart';

class Gap extends StatelessWidget {
  const Gap(this.mainAxisExtent, {super.key, this.crossAxisExtent, this.color})
    : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
      assert(crossAxisExtent == null || crossAxisExtent >= 0);

  const Gap.expand(double mainAxisExtent, {Key? key, Color? color})
    : this(mainAxisExtent, key: key, crossAxisExtent: double.infinity, color: color);

  final double mainAxisExtent;
  final double? crossAxisExtent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scrollableState = Scrollable.maybeOf(context);
    final AxisDirection? axisDirection = scrollableState?.axisDirection;
    final Axis? fallbackDirection = axisDirection == null ? null : axisDirectionToAxis(axisDirection);

    return _RawGap(
      mainAxisExtent,
      crossAxisExtent: crossAxisExtent,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }
}

class MaxGap extends StatelessWidget {
  const MaxGap(this.mainAxisExtent, {super.key, this.crossAxisExtent, this.color});

  const MaxGap.expand(double mainAxisExtent, {Key? key, Color? color})
    : this(mainAxisExtent, key: key, crossAxisExtent: double.infinity, color: color);

  final double mainAxisExtent;

  final double? crossAxisExtent;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: _RawGap(mainAxisExtent, crossAxisExtent: crossAxisExtent, color: color),
    );
  }
}

class _RawGap extends LeafRenderObjectWidget {
  const _RawGap(this.mainAxisExtent, {this.crossAxisExtent, this.color, this.fallbackDirection})
    : assert(mainAxisExtent >= 0 && mainAxisExtent < double.infinity),
      assert(crossAxisExtent == null || crossAxisExtent >= 0);

  final double mainAxisExtent;

  final double? crossAxisExtent;

  final Color? color;

  final Axis? fallbackDirection;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGapUtil(
      mainAxisExtent: mainAxisExtent,
      crossAxisExtent: crossAxisExtent ?? 0,
      color: color,
      fallbackDirection: fallbackDirection,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderGapUtil renderObject) {
    renderObject
      ..mainAxisExtent = mainAxisExtent
      ..crossAxisExtent = crossAxisExtent ?? 0
      ..color = color
      ..fallbackDirection = fallbackDirection;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('mainAxisExtent', mainAxisExtent));
    properties.add(DoubleProperty('crossAxisExtent', crossAxisExtent, defaultValue: 0));
    properties.add(ColorProperty('color', color));
    properties.add(EnumProperty<Axis>('fallbackDirection', fallbackDirection));
  }
}
