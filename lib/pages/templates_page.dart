import 'package:flutter/material.dart';

import '../widgets/app/secondary_scaffold.dart';
import 'chart_editor/chart_editor_page.dart';
import '../repositories/chart_template_repository.dart';

class TemplatesPage extends StatelessWidget {
  static const String baseRoute = '/templates';

  //
  final String lib;

  TemplatesPage({@required this.lib});

  //
  final List<ScrollController> scrollControllers = [];

  //
  List<String> tabs = [];

  @override
  Widget build(BuildContext context) {
    //
    Map<String, dynamic> templates =
        ChartTemplateRepository.getTemplatesByLibrary(lib);

    //
    final screenWidth = MediaQuery.of(context).size.width;

    //
    final columns = (screenWidth / 350).round();

    //
    if (tabs.isEmpty) {
      for (final template in templates.values) {
        //
        tabs.add(template['title']);
        //
        scrollControllers.add(ScrollController());
      }
    }

    return DefaultTabController(
      length: tabs.length,
      child: SecondaryScaffold(
        appBarTitle: 'Select a template',
        appBarBottom: TabBar(
          isScrollable: true,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
        body: TabBarView(
          children: [
            for (final MapEntry templateEntry in templates.entries)
              Scrollbar(
                controller: scrollControllers[
                    templates.keys.toList().indexOf(templateEntry.key)],
                isAlwaysShown: true,
                child: GridView.count(
                  controller: scrollControllers[
                      templates.keys.toList().indexOf(templateEntry.key)],
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: columns > 0 ? columns : 1,
                  childAspectRatio: 1.33,
                  // 400/300
                  children: [
                    for (final template in templateEntry.value['templates'])
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
                          // Pop for Engines page
                          Navigator.pop(context);
                          // Pop for Templates page
                          Navigator.pop(context);
                          // Go to editor
                          Navigator.pushNamed(
                            context,
                            ChartEditor.baseRoute +
                                '/template/' +
                                template['id'],
                          );
                        },
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
