import 'package:architecture_example/domain/my_bloc.dart';
import 'package:architecture_example/domain/my_bloc_provider.dart';
import 'package:architecture_example/widgets/linear_progress_painter.dart';
import 'package:architecture_example/widgets/margins.dart';
import 'package:architecture_example/widgets/stream_animation_builder.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architecture example',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Architecture example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _myBloc = new MyBloc();
    //starts the time and sends emit the first stream update
    _myBloc.init();

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(
      (rec) {
        print('${rec.sequenceNumber} ${rec.message}');
      },
    );

    super.initState();
  }

  MyBloc _myBloc;
  @override
  void dispose() {
    _myBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(widget.title),
      ),

      //inherited Widget injects the Provider in the Widget tree
      //this allows you to access MyBloc with MyBlocProvider.of(context).
      body: MyBlocProvider(
        bloc: _myBloc,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Margins(
                    left: 100.0,
                    right: 50.0,
                    top: 5,
                    bottom: 5,
                    height: 30,
                    child: ProgressWidget(),
                  ),
                ),
              ],
            ),
            /*     Row(
              children: <Widget>[
                Expanded(
                  child: Margins(
                    all: 20.0,
                    height: 5,
                    child: ProgressWidget(),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: PercentMargins(
                    right: 20.0,
                    height: 20,
                    child: ProgressWidget(),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: PercentMargins(
                    top: 20,
                    left: 20.0,
                    height: 20,
                    child: ProgressWidget(),
                  ),
                ),
              ],
            ),
            Margins(
              all: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PercentMargins(
                      top: 20,
                      left: 20.0,
                      right: 20.0,
                      bottom: 10,
                      height: 10,
                      child: ProgressWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Margins(
              all: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PercentMargins(
                      all: 30,
                      height: 10,
                      child: ProgressWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Margins(
              all: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PercentMargins(
                      right: 50,
                      height: 10,
                      child: ProgressWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Margins(
              all: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PercentMargins(
                      left: 50,
                      height: 10,
                      child: ProgressWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Margins(
              all: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PercentMargins(
                      all: 40,
                      height: 10,
                      child: ProgressWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Margins(
              all: 10,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PercentMargins(
                      bottom: 40,
                      height: 10,
                      child: ProgressWidget(),
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

// The point here is that we don't need any state
// in the Widget because the bloc
// should contain it all. A general rule is one or more blocs per screen.
class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamAnimationBuilder<double>(
        streamValue: MyBlocProvider.of(context).progress,
        builder: (value) => CustomPaint(
          painter: LinearProgressPainter(
            value: value / 100.0,
          ),
        ),
      );
}
