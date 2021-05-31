import 'package:flutter/material.dart';
import 'package:chartmaker_app/app/data/models/app_user.dart';
import 'package:chartmaker_app/app/modules/account/widgets/logo_graphic_header.dart';

class Avatar extends StatelessWidget {
  Avatar(
    this.user,
  );
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    if (user.photoUrl == '') {
      return LogoGraphicHeader();
    }
    return Hero(
      tag: 'User Avatar Image',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          radius: 35,
          child: ClipOval(
            child: Image.network(
              user.photoUrl!,
              fit: BoxFit.cover,
              width: 70.0,
              height: 70.0,
            ),
          )),
    );
  }
}
