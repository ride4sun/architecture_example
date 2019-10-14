// The point here is that we don't need any state
// in the Widget because the bloc
// should contain it all. A general rule is one or more blocs per screen.t';
import 'package:architecture_example/domain/stream_value.dart';
import 'package:architecture_example/widgets/linear_progress_painter.dart';
import 'package:architecture_example/widgets/stream_animation_builder.dart';
import 'package:flutter/material.dart';

//class ProgressWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) => StreamAnimationBuilder<double>(
//        streamValue: MyBlocProvider.of(context).progress,
//        builder: (value) => CustomPaint(
//          painter: LinearProgressPainter(
//            value: value / 100.0,
//          ),
//        ),
//      );
//}

//A more universal bloc ready ProgressWidget
class ProgressWidget extends StatelessWidget {
  ProgressWidget(
      {@required this.streamValue,
      this.animationDuration = const Duration(milliseconds: 250),
      this.curve = Curves.easeInOut});

  final ReadStreamValue<double> streamValue;
  final Duration animationDuration;
  final Curve curve;

  @override
  Widget build(BuildContext context) => StreamAnimationBuilder<double>(
        streamValue: streamValue,
        animationDuration: animationDuration,
        curve: curve,
        builder: (value) => CustomPaint(
          painter: LinearProgressPainter(
            value: value / 100.0,
          ),
        ),
      );
}
