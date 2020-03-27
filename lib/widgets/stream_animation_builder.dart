import 'package:animator/animator.dart';
import 'package:architecture_example/domain/stream_value.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final _log = new Logger('streamAnimationBuilder.dart');

class StreamAnimationBuilder<T extends double> extends StatelessWidget {
  final ReadStreamValue<T> streamValue;
  final Widget Function(T) builder;
  final Duration Function() durationCallback;
  final Curve curve;

  StreamAnimationBuilder(
      {@required this.streamValue,
      @required this.builder,
      @required this.durationCallback,
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
            Duration duration = durationCallback();
            _log.finest("Animaion Duration: $duration");

            _log.finest(
                "ANIMATION VALUES IN StreamAnimationBuilder: previous: $previousValue , value: $value");

            return Animator(
                resetAnimationOnRebuild: true,
                tween: Tween<T>(begin: previousValue, end: value),
                cycles: 1,
                duration: duration,
                curve: curve,
                builder: (anim) => builder(anim.value));
          }
        },
      );
}
