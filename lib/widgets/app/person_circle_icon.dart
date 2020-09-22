import 'package:flutter/material.dart';

class PersonCircleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 39,
      height: 39,
      margin: const EdgeInsets.all(9),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.none,
          child: Icon(Icons.person, size: 37),
        ),
      ),
    );
  }
}
