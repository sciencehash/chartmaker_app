import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/editor/editor_cubit.dart';
import 'dataset_bottom_sheet.dart';
import 'embed_content.dart';

class DrawerMenu extends StatelessWidget {
  final VoidCallback onSavePressed;
  final bool drawerMode;

  const DrawerMenu({
    Key key,
    this.drawerMode = true,
    @required this.onSavePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlineButton(
              child: Text('Save Chart'),
              onPressed: () {
                Navigator.pop(context);
                onSavePressed();
              },
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.arrow_downward),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 15),
          ],
        ),
        Divider(
          height: 12,
          thickness: .5,
        ),
        SizedBox(height: 10),
        //
        _MainMenuTile(
          icon: Icons.equalizer,
          label: 'Datasets',
          drawerMode: drawerMode,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.bloc<EditorCubit>(),
                  child: DatasetBottomSheet(),
                ),
              ),
            );
          },
        ),
        //
        _MainMenuTile(
          icon: Icons.code,
          label: 'Embed',
          onPressed: () async {
            Navigator.pop(context);
            //
            await showModalBottomSheet(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.bloc<EditorCubit>(),
                child: EmbedContent(),
              ),
            );
          },
          drawerMode: drawerMode,
        ),
        //
        _MainMenuTile(
          icon: Icons.file_download,
          label: 'Export',
          onPressed: () {
            // Close the bottom sheet
            Navigator.pop(context);
            // Request the PNG
            context.bloc<EditorCubit>().downloadAsPNG();
          },
          drawerMode: drawerMode,
        ),
      ],
    );
  }
}

class _MainMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;
  final Function onPressed;
  final bool drawerMode;

  const _MainMenuTile({
    Key key,
    this.icon,
    this.label,
    this.routeName,
    this.onPressed,
    this.drawerMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final String currentRouteName = ModalRoute.of(context).settings.name;
    //
    final bool isActiveItem = routeName == null
        ? false
        : ((routeName == '/' && currentRouteName == routeName) ||
            (routeName != '/' && currentRouteName.startsWith(routeName)));

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
        onTap: onPressed ??
            () {
              if (ModalRoute.of(context).settings.name != routeName) {
                Navigator.pushNamed(context, routeName);
              }
            },
      ),
    );
  }
}
