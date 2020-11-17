import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/app/primary_scaffold.dart';
import '../widgets/app/page_title.dart';

class ProfilePage extends StatelessWidget {
  static const String route = '/profile';

  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = '';// (context.bloc<AuthenticationCubit>().state as Authenticated).user.email;
    return PrimaryScaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(title: 'Profile'),
            Text(email ?? 'Anonymous'),
          ],
        ),
      ),
    );
  }
}
