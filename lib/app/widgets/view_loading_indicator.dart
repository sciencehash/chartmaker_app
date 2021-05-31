import 'package:flutter/material.dart';

class ViewLoadingIndicator extends StatelessWidget {
  const ViewLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: CircularProgressIndicator(strokeWidth: 1),
      ),
    );
  }
}
