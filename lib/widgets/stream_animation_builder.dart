import 'package:animator/animator.dart';
import 'package:architecture_example/domain/stream_value.dart';
import 'package:flutter/material.dart';

class StreamAnimationBuilder<T extends double> extends StatelessWidget {
  final ReadStreamValue<T> streamValue;
  final Widget Function(T) builder;
  final Duration animationDuration;
  final Curve curve;

  StreamAnimationBuilder(
      {@required this.streamValue,
      @required this.builder,
      this.animationDuration = const Duration(milliseconds: 250),
      this.curve = Curves.easeInOut});

  @override
  Widget build(BuildContext context) => StreamBuilder<T>(
        stream: streamValue.stream,
        initialData: null,
        builder: (context, snapshot) {
          T previousValue = streamValue.previousValue;
          T value = streamValue.value;

          if (snapshot.data == null ||
              snapshot.hasError ||
              previousValue == null ||
              value == null) {
            return Container();
          } else {
            print("ANIMATION VALUES: $previousValue , $value");

            return Animator(
                resetAnimationOnRebuild: true,
                tween: Tween<T>(begin: previousValue, end: value),
                cycles: 1,
                duration: animationDuration,
                curve: curve,
                builder: (anim) => builder(anim.value));
          }
        },
      );
}
