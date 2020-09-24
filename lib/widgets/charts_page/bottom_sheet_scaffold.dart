import 'package:flutter/material.dart';

class ChartsBottomSheetScaffold extends StatelessWidget {
  //
  final String appBarTitle;

  //
  final Widget body;

  ChartsBottomSheetScaffold({
    Key key,
    @required this.appBarTitle,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            FloatingActionButton(
              child: Icon(Icons.arrow_back),
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Center(
                child: Text(
                  appBarTitle,
                  style: screenWidth > 400
                      ? Theme.of(context).textTheme.headline5
                      : Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            // Needed for a centered title
            SizedBox(width: 50),
          ],
        ),
        SizedBox(height: 30),
        Expanded(
          child: body,
        ),
      ],
    );
  }
}
