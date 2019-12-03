import 'package:flutter/widgets.dart';

class LifecycleWatcher extends StatefulWidget {
  @override
  State createState() {
    return _LifecycleWatcherState();
  }
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState;

  @override
  Widget build(BuildContext context) {
    return Center(child: getWidget());
//    return Center(child: if (null == _appLifecycleState)
//    {
//      return Text('This widget has not observed any lifecycle changes.',
//          textDirection: TextDirection.ltr);
//    } else {
//    return Text(
//    'The most recent lifecycle state this widget observed was: $_appLifecycleState.',
//    textDirection: TextDirection.ltr);
//    });
  }

  Widget getWidget() {
    if (null == _appLifecycleState) {
      return Text('This widget has not observed any lifecycle changes.',
          textDirection: TextDirection.ltr);
    } else {
      return Text(
          'The most recent lifecycle state this widget observed was: $_appLifecycleState.',
          textDirection: TextDirection.ltr);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
    });
  }
}
