import 'package:flutter/material.dart';

class HeaderIsotype extends StatelessWidget {
  const HeaderIsotype({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withAlpha(17)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Image.asset('assets/images/chartmaker-isotype.png'),
    );
  }
}
