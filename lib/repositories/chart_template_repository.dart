class ChartTemplateRepository {
  final Map templates = {
    'lineTemplate01': {
      'lib': 'chartjs',
      'title': 'Simple Line Chart',
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
  };

  Map getTemplate(String templateId) {
    return templates[templateId] ?? {};
  }
}
