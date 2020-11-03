import 'package:flutter/material.dart';

class DatasetsEditorScaffold extends StatelessWidget {
  //
  final String appBarTitle;

  //
  final Widget body;

  //
  final Widget floatingActionButton;

  //
  final Function onApplyPressed;

  DatasetsEditorScaffold({
    Key key,
    @required this.appBarTitle,
    @required this.body,
    this.floatingActionButton,
    this.onApplyPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              FloatingActionButton(
                heroTag: 'EditorFabBack',
                child: Icon(Icons.arrow_back),
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 7),
              Expanded(
                child: Text(
                  appBarTitle,
                  style: screenWidth > 400
                      ? Theme.of(context).textTheme.headline5
                      : Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(width: 7),
              OutlineButton(
                child: Text('Apply'),
                textColor: Colors.green,
                onPressed: onApplyPressed,
              ),
              SizedBox(width: 7),
              FloatingActionButton(
                child: Icon(Icons.help_outline),
                heroTag: 'EditorFabHelp',
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Help'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Each dataset allows you to configure options that will replace the general options of the chart.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          Expanded(
            child: body,
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
