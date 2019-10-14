import 'package:architecture_example/domain/my_bloc.dart';
import 'package:architecture_example/domain/my_bloc_provider.dart';
import 'package:architecture_example/widgets/margins.dart';
import 'package:architecture_example/widgets/progress_widget.dart';
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
    return MyBlocProvider(
      bloc: _myBloc,
      child: Scaffold(
          backgroundColor: Colors.black54,
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: ProgressRender()),
    );
  }
}

class ProgressRender extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Column(
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
                  child: ProgressWidget(
                    streamValue: MyBlocProvider.of(context).progress,
                    curve: Curves.bounceOut,
                    animationDuration: const Duration(milliseconds: 700),
                  ),
                ),
              ),
            ],
          ),
//           Row(
//              children: <Widget>[
//                Expanded(
//                  child: Margins(
//                    all: 20.0,
//                    height: 5,
//                    child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                  ),
//                ),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: PercentMargins(
//                    right: 20.0,
//                    height: 20,
//                    child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                  ),
//                ),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: PercentMargins(
//                    top: 20,
//                    left: 20.0,
//                    height: 20,
//                    child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                  ),
//                ),
//              ],
//            ),
//            Margins(
//              all: 10,
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: PercentMargins(
//                      top: 20,
//                      left: 20.0,
//                      right: 20.0,
//                      bottom: 10,
//                      height: 10,
//                      child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Margins(
//              all: 10,
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: PercentMargins(
//                      all: 30,
//                      height: 10,
//                      child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Margins(
//              all: 10,
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: PercentMargins(
//                      right: 50,
//                      height: 10,
//                      child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Margins(
//              all: 10,
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: PercentMargins(
//                      left: 50,
//                      height: 10,
//                      child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Margins(
//              all: 10,
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: PercentMargins(
//                      all: 40,
//                      height: 10,
//                      child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Margins(
//              all: 10,
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: PercentMargins(
//                      bottom: 40,
//                      height: 10,
//                      child: ProgressWidget(streamValue: MyBlocProvider.of(context).progress),
//                    ),
//                  ),
//                ],
//              ),
//            ),
        ],
      );
}
