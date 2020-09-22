import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
    this.drawerMode = true,
  }) : super(key: key);

  final bool drawerMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!drawerMode) SizedBox(height: 25),
        //
        _MainMenuTile(
          icon: Icons.library_books,
          label: 'My library',
          routeName: '/', // TEMP //LibraryChartsPage.route,
          drawerMode: drawerMode,
        ),
        //
//         _MainMenuTile(
//           icon: Icons.settings,
//           label: 'Settings',
//           routeName: SettingsPage.route,
//           drawerMode: drawerMode,
//         ),
//         //
//         _MainMenuTile(
//           icon: Icons.help,
//           label: 'Help',
//           routeName: HelpPage.route,
//           drawerMode: drawerMode,
//         ),
//         //
//         _MainMenuTile(
//           icon: Icons.announcement,
//           label: 'Send feedback',
//           routeName: SendFeedbackPage.route,
//           drawerMode: drawerMode,
//         ),
// //        //
//        _MainMenuTile(
//          icon: Icons.forward,
//          label: 'Student area',
//          routeName: '/student-area',
//          drawerMode: drawerMode,
//        ),
        //
        _MainMenuTile(
          icon: Icons.exit_to_app,
          label: 'Sign out',
          routeName: '/signout',
          drawerMode: drawerMode,
        ),
      ],
    );
  }
}

class _MainMenuTile extends StatelessWidget {
  const _MainMenuTile({
    Key key,
    this.icon,
    this.label,
    this.routeName,
    this.drawerMode = false,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final String routeName;
  final bool drawerMode;

  @override
  Widget build(BuildContext context) {
    //
    final String currentRouteName = ModalRoute.of(context).settings.name;
    //
    final bool isActiveItem =
        (routeName == '/' && currentRouteName == routeName) ||
            (routeName != '/' && currentRouteName.startsWith(routeName));

    //
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          width: drawerMode ? null : 240,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Icon(
                  icon,
                  color: isActiveItem ? Color(0xff00B5E3) : Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 1,
                    color: isActiveItem ? Color(0xff00B5E3) : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          if (ModalRoute.of(context).settings.name != routeName) {
            Navigator.pushNamed(context, routeName);
          }
        },
      ),
    );
  }
}
