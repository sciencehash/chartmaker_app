import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class LeftPanelsTabs extends StatelessWidget {
  final List<Tab> tabBarChildren;
  final List<Widget> tabViewChildren;

  const LeftPanelsTabs({
    Key key,
    @required this.tabBarChildren,
    @required this.tabViewChildren,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(.06),
      width: 430,
      height: MediaQuery.of(context).size.height,
      child: VerticalTabs(
        tabsWidth: 60,
        backgroundColor: Colors.transparent,
        tabBackgroundColor: Colors.transparent,
        tabsBackgroundColor: Colors.transparent,
        selectedTabBackgroundColor: Colors.blue,
        tabBorderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        tabs: tabBarChildren,
        contents: tabViewChildren,
      ),
    );
  }
}
