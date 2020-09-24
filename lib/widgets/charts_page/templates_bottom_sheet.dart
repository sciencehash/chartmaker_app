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

    return ChartsBottomSheetScaffold(
      appBarTitle: 'Select a template',
      body: SingleChildScrollView(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            for (Map template in templates)
              FlatButton(
                child: Text(
                  template['title'],
                  style: TextStyle(color: Colors.black87),
                ),
                padding: const EdgeInsets.all(50),
                color: Colors.white,
                minWidth: 200,
                onPressed: () {
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
