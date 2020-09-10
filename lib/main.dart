// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
// import 'dart:ui' as ui;
import './UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
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
  Widget _iframeWidget;

  final IFrameElement _iframeElement = IFrameElement();

  @override
  void initState() {

    _iframeElement.height = '500';
    _iframeElement.width = '500';
    // _iframeElement.src = 'https://www.youtube.com/embed/RQzhAQlg2JQ';
    _iframeElement.src = '/test.html';
    _iframeElement.style.border = 'none';

    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have :',
            ),
            SizedBox(
              height: 500,
              width: 400,
              child: _iframeWidget,
            ),
            RaisedButton(
              child: Text('Change'),
              onPressed: (){
                _iframeElement.src = 'https://www.youtube.com/embed/RQzhAQlg2JQ';
              },
            ),
          ],
        ),
      ),
    );
  }
}

