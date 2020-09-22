import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';
import 'package:chartmaker_app/widgets/app/person_circle_icon.dart';

import 'header_isotype.dart';
import '../../pages/charts_page.dart';
import '../../pages/help_page.dart';
import '../../pages/profile_page.dart';
import '../../pages/send_feedback_page.dart';
import '../../pages/settings_page.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key key, Widget body, Widget floatingActionButton})
      : _body = body,
        _floatingActionButton = floatingActionButton,
        super(key: key);

  final Widget _body;
  final Widget _floatingActionButton;

  @override
  Widget build(BuildContext context) {
    //
    const double drawerMaxScreenWidth = 900;

    //
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          child: HeaderIsotype(),
        ),
        title: Text(
          'Chart Maker',
          style: Theme.of(context).textTheme.headline6,
        ),
        // centerTitle: true,
        actions: screenWidth < drawerMaxScreenWidth
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Container(
                        width: 39,
                        height: 33,
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
                      ),
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        if (ModalRoute.of(context).settings.name !=
                            ProfilePage.route) {
                          Navigator.pushNamed(context, ProfilePage.route);
                        }
                      },
                    ),
                  ),
                ),
              ],
      ),
      endDrawer: screenWidth >= drawerMaxScreenWidth
          ? null
          : Drawer(
              child: Container(
                color: Color(0xff2C333D),
                child: Scrollbar(
                  child: ListView(
                    children: [
                      // DrawerHeader(
                      //   child: Text('a'),
                      // ),
                      // Drawer Header
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 3),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: PersonCircleIcon(),
                            ),
                            SizedBox(width: 7),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  OutlineButton(
                                    child: Text('View profile'),
                                    // textColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      if (ModalRoute.of(context).settings.name !=
                                          ProfilePage.route) {
                                        Navigator.pushNamed(context, ProfilePage.route);
                                      }
                                    },
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Drawer Menu
                      _MainMenu(drawerMode: true),
                    ],
                  ),
                ),
              ),
            ),
      body: screenWidth < drawerMaxScreenWidth
          ? _body
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LeftMenuBar(),
                Container(
                  width: MediaQuery.of(context).size.width - 240,
                  child: _body,
                ),
              ],
            ),
      floatingActionButton: _floatingActionButton,
    );
  }
}

class _LeftMenuBar extends StatelessWidget {
  const _LeftMenuBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2C333D),
      height: MediaQuery.of(context).size.height,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: _MainMenu(),
        ),
      ),
    );
  }
}

class _MainMenu extends StatelessWidget {
  const _MainMenu({
    Key key,
    this.drawerMode = false,
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
        _MainMenuTile(
          icon: Icons.settings,
          label: 'Settings',
          routeName: SettingsPage.route,
          drawerMode: drawerMode,
        ),
        //
        _MainMenuTile(
          icon: Icons.help,
          label: 'Help',
          routeName: HelpPage.route,
          drawerMode: drawerMode,
        ),
        //
        _MainMenuTile(
          icon: Icons.announcement,
          label: 'Send feedback',
          routeName: SendFeedbackPage.route,
          drawerMode: drawerMode,
        ),
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
