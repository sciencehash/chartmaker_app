import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key key,
    @required this.title,
    this.details = '',
  }) : super(key: key);

  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    //
    bool showNavPopButton = false;
    //
    if (Navigator.canPop(context) && MediaQuery.of(context).size.width > 500) {
      showNavPopButton = true;
    }

    //
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showNavPopButton)
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            if (showNavPopButton) SizedBox(width: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 25, fontFamily: 'Ubuntu-Regular'),
                ),
                if (details.isNotEmpty) SizedBox(width: 15),
                if (details.isNotEmpty)
                  Text(
                    details,
                    style: TextStyle(fontSize: 20, fontFamily: 'Ubuntu-Regular', color: Colors.white70),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageSubTitle extends StatelessWidget {
  const PageSubTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Text(
        title,
        style: TextStyle(fontSize: 21, fontFamily: 'Ubuntu-Regular'),
      ),
    );
  }
}
