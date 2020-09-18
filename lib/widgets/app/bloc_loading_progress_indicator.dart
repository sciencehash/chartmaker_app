import 'package:flutter/material.dart';

class BlocLoadingProgressIndicator extends StatelessWidget {
  final String label;

  BlocLoadingProgressIndicator({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            ),
          ),
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                label,
                style: TextStyle(color: Colors.white60),
              ),
            ),
        ],
      ),
    );
  }
}
