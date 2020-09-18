import 'package:flutter/material.dart';

class RedirectionPage extends StatefulWidget {
  final String routeName;
  final bool clearHistory;

  const RedirectionPage({
    Key key,
    @required this.routeName,
    this.clearHistory = false,
  }) : super(key: key);

  @override
  _RedirectionPageState createState() => _RedirectionPageState();
}

class _RedirectionPageState extends State<RedirectionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => widget.clearHistory
          ? Navigator.pushNamedAndRemoveUntil(
        context,
        widget.routeName,
            (Route<dynamic> route) => false,
      )
          : Navigator.pushNamed(context, widget.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}