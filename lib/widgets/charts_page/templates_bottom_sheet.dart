import 'package:chartmaker_app/pages/editor.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_scaffold.dart';
import '../../repositories/chart_template_repository.dart';

class TemplatesBottomSheet extends StatelessWidget {
  //
  final String lib;

  TemplatesBottomSheet({@required this.lib});

  @override
  Widget build(BuildContext context) {
    //
    List<Map> templates = ChartTemplateRepository.getTemplatesByLibrary(lib);

    //
    final screenWidth = MediaQuery.of(context).size.width;

    //
    final columns = (screenWidth / 350).round();

    //
    final ScrollController scrollController = ScrollController();

    return ChartsBottomSheetScaffold(
      appBarTitle: 'Select a template',
      body: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: GridView.count(
          controller: scrollController,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: columns > 0 ? columns : 1,
          childAspectRatio: 1.33, // 400/300
          children: [
            for (Map template in templates)
              FlatButton(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        child: Image.asset(
                          'assets/images/templates/${template['id']}.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      template['title'],
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                minWidth: 200,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    ChartEditor.baseRoute + '/template/' + template['id'],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
