import 'package:flutter/material.dart';

class EmptyListMessage extends StatelessWidget {
  const EmptyListMessage({
    @required this.message,
    this.buttonLabel,
    this.onButtonPressed,
    Key key,
  }) : super(key: key);

  final String message;
  final String buttonLabel;
  final Function onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                message,
                textAlign: TextAlign.center,                
                style: TextStyle(fontSize: 18, height: 1.4),
              ),
            ),
            if (onButtonPressed != null)
              OutlineButton(
                child: Text(buttonLabel ?? 'Go!'),
                onPressed: onButtonPressed,
              )
          ],
        ),
      ),
    );
  }
}