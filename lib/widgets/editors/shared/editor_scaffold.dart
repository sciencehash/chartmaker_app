import 'package:flutter/material.dart';

import 'drawer_menu.dart';
import 'top_tool_bar.dart';
import 'left_panels_tabs.dart';

class EditorScaffold extends StatefulWidget {
  final List<Tab> leftTabBarChildren;
  final List<Widget> leftTabViewChildren;

  const EditorScaffold({
    Key key,
    Widget body,
    Widget floatingActionButton,
    @required this.leftTabBarChildren,
    @required this.leftTabViewChildren,
  })  : _body = body,
        _floatingActionButton = floatingActionButton,
        super(key: key);

  final Widget _body;
  final Widget _floatingActionButton;

  @override
  _EditorScaffoldState createState() => _EditorScaffoldState();
}

class _EditorScaffoldState extends State<EditorScaffold> {
  String _chartName = '';

  @override
  Widget build(BuildContext context) {
    //
    const double drawerMaxScreenWidth = 900;

    //
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            if (screenWidth > 600)
              Text(
                'Chart Maker',
                style: Theme.of(context).textTheme.headline6,
              ),
            if (screenWidth > 600) SizedBox(width: 30),
            Expanded(
              child: TextFormField(
                initialValue: _chartName,
                onChanged: (value) {
                  setState(() => _chartName = value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(_chartName.isNotEmpty
                      ? Icons.label
                      : Icons.label_outline),
                  labelText: 'Chart name',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.only(bottom: 10),
                  border: InputBorder.none,
                ),
                autocorrect: false,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: screenWidth < drawerMaxScreenWidth
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: OutlineButton(
                    child: Text('Save'),
                    onPressed: () {},
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
                      DrawerHeader(
                        child: Text('a'),
                      ),
                      DrawerMenu(),
                    ],
                  ),
                ),
              ),
            ),
      body: screenWidth < drawerMaxScreenWidth
          ? widget._body
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeftPanelsTabs(
                  tabBarChildren: widget.leftTabBarChildren,
                  tabViewChildren: widget.leftTabViewChildren,
                ),
                Expanded(
                  child: Column(
                    children: [
                      TopToolBar(),
                      Expanded(
                        child: widget._body,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: widget._floatingActionButton,
    );
  }
}
