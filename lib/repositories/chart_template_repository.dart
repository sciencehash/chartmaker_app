class ChartTemplateRepository {
  static final List<Map> _templates = [
    // Template
    {
      'id': 'lineTemplate01',
      'lib': 'chartjs',
      'title': 'Simple Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
          ],
          'datasets': [
            {
              'label': 'My First dataset',
              'backgroundColor': 'rgb(255, 99, 132)',
              'borderColor': 'rgb(255, 99, 132)',
              'data': [0, 10, 15, 2, 20, 30, 45]
            }
          ]
        },
        'options': {},
      },
    },
    // Template
    {
      'id': 'lineTemplate02',
      'lib': 'chartjs',
      'title': 'Simple Line Chart 2',
      'config': {},
    },
    // Template
    {
      'id': 'lineTemplateA01',
      'lib': 'apexcharts',
      'title': 'Simple Line Chart A1',
      'config': {
        'chart': {'type': 'line'},
        'series': [
          {
            'name': 'sales',
            'data': [30, 40, 35, 50, 49, 60, 70, 91, 125]
          }
        ],
        'xaxis': {
          'categories': [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999]
        }
      },
    },
    // Template
    {
      'id': 'lineTemplateA02',
      'lib': 'apexcharts',
      'title': 'Simple Line Chart A2',
      'config': {},
    },
  ];

  static Map getTemplateById(String templateId) {
    return _templates.firstWhere(
      (element) => element['id'] == templateId,
      orElse: () => {},
    );
  }

  static Map getFirstTemplate() {
    return _templates.first;
  }

  static List<Map> getTemplatesByLibrary(String lib) {
    return _templates.where((element) => element['lib'] == lib).toList();
  }
}
