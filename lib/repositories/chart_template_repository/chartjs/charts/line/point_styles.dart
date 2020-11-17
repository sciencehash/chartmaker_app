import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_point_style_line = {
  'id': 'chartjs-point-style-line',
  'lib': 'chartjs',
  'title': 'Point Style Line Chart',
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
        'July'
      ],
      'datasets': [
        {
          'label': 'My First dataset',
          'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
          'borderColor': ChartjsTemplateUtils.chartColors['red'],
          'data': [10, 23, 5, 99, 67, 43, 0],
          'fill': false,
          'pointRadius': 10,
          'pointHoverRadius': 15,
          'showLine': false // no line shown
        }
      ]
    },
    'options': {
      'responsive': true,
      'title': {'display': true, 'text': 'Point Style: circle'},
      'legend': {'display': false},
      'elements': {
        'point': {'pointStyle': 'circle'}
      }
    }
  },
};