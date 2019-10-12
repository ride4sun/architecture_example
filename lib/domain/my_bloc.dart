import 'dart:async';
import 'dart:math';

import 'package:architecture_example/domain/stream_value.dart';

class MyBloc {
  init() {
    _timer = new Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        var random = new Random();
        //generates a number between 0 and 1.0
        _progress.value = random.nextDouble() * 100.0;
      },
    );
  }

  //call dispose when you delete the object
  dispose() {
    _progress.dispose();
  }

  var _timer;

  ReadStreamValue<double> get progress => _progress;
  final StreamValue<double> _progress =
      StreamValue<double>(seedValue: 0.0, name: 'progress');
}
