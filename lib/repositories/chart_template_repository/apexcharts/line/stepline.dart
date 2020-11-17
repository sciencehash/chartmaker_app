final Map apexcharts_step_line = {
  'id': 'apexcharts-step-line',
  'lib': 'apexcharts',
  'title': 'Stepline Chart',
  'config': {
    'chart': {'type': 'line', 'height': 350},
    'stroke': {
      'curve': 'stepline',
    },
    'dataLabels': {'enabled': false},
    'title': {'text': 'Stepline Chart', 'align': 'left'},
    'markers': {
      'hover': {'sizeOffset': 4}
    },
    'series': [
      {
        'data': [34, 44, 54, 21, 12, 43, 33, 23, 66, 66, 58]
      }
    ]
  },
};