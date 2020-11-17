import 'package:flutter/material.dart';

class SecondaryScaffold extends StatelessWidget {
  final String appBarTitle;
  final PreferredSizeWidget appBarBottom;
  final Widget body;
  final Widget floatingActionButton;

  const SecondaryScaffold({
    Key key,
    this.appBarTitle = 'Chart Maker',
    this.appBarBottom,
    this.body,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          appBarTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
        bottom: appBarBottom,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}