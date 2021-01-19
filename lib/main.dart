import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(children: [
          UiKitView(
            viewType: 'NativeViewExample',
          ),
          DraggableButtonBar(
            toggleButtonEnabled: _toggleButton,
            buttonEnabled: buttonEnabled,
          ),
        ]),
      ),
    );
  }

  void _toggleButton() {
    log(' ~~~~~~~~~ Button received press ~~~~~~~~~ ');
    setState(() {
      buttonEnabled = !buttonEnabled;
    });
  }
}

class DraggableButtonBar extends StatefulWidget {
  final VoidCallback toggleButtonEnabled;
  final bool buttonEnabled;

  DraggableButtonBar({
    @required this.toggleButtonEnabled,
    @required this.buttonEnabled,
  });

  @override
  State<StatefulWidget> createState() => DraggableButtonBarState();
}

class DraggableButtonBarState extends State<DraggableButtonBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _initialTopPosition(),
      left: 0,
      right: 0,
      child: GestureDetector(
        onVerticalDragDown: _dragDown,
        onVerticalDragUpdate: _dragUpdate,
        onVerticalDragEnd: _dragEnd,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildContent(),
            _buildBottomPadding(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {Widget icon,
      Color color = Colors.white,
      Color buttonColor = Colors.white,
      VoidCallback onPressed}) {
    return Container(
      height: 64,
      width: 64,
      decoration: ShapeDecoration(
        color: buttonColor,
        shape: CircleBorder(),
      ),
      child: Ink(
        child: IconButton(
          iconSize: 22,
          color: color,
          splashColor: color.withOpacity(0.5),
          icon: icon,
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildButton(
                icon: widget.buttonEnabled
                    ? Icon(Icons.camera_enhance_rounded)
                    : Icon(Icons.flip_camera_ios),
                buttonColor: widget.buttonEnabled ? Colors.grey : Colors.pink,
                onPressed: widget.toggleButtonEnabled,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPadding() {
    return Container(
      height: 100,
      color: Colors.black26,
    );
  }

  double _initialTopPosition() {
    if (context != null) {
      var headerHeight = 100;

      var mediaQuery = MediaQuery.of(context);
      var screenHeight = mediaQuery.size.height;
      var safePadding = mediaQuery.padding.bottom;
      var safePaddingTop = mediaQuery.viewInsets.top;
      return screenHeight - headerHeight - safePadding - safePaddingTop;
    }
    return 0;
  }

  void _dragDown(DragDownDetails details) {
    log('------- _dragDown -------');
  }

  void _dragUpdate(DragUpdateDetails details) {
    log('------- _dragUpdate -------');
  }

  void _dragEnd(DragEndDetails details) {
    log('------- _dragEnd -------');
  }
}
