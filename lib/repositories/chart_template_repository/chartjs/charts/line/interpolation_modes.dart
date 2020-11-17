import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_interpolation_line = {
  'id': 'chartjs-interpolation-line',
  'lib': 'chartjs',
  'title': 'Interpolation Line Chart',
  'config': {
    'type': 'line',
    'data': {
      'labels': [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12'
      ],
      'datasets': [
        {
          'label': 'Cubic interpolation (monotone)',
          'data': [
            0,
            20,
            20,
            60,
            60,
            120,
            100,
            180,
            120,
            125,
            105,
            110,
            170
          ],
          'borderColor': ChartjsTemplateUtils.chartColors['red'],
          'backgroundColor': 'rgba(0, 0, 0, 0)',
          'fill': false,
          'cubicInterpolationMode': 'monotone'
        },
        {
          'label': 'Cubic interpolation (default)',
          'data': [
            0,
            20,
            20,
            60,
            60,
            120,
            100,
            180,
            120,
            125,
            105,
            110,
            170
          ],
          'borderColor': ChartjsTemplateUtils.chartColors['blue'],
          'backgroundColor': 'rgba(0, 0, 0, 0)',
          'fill': false,
        },
        {
          'label': 'Linear interpolation',
          'data': [
            0,
            20,
            20,
            60,
            60,
            120,
            100,
            180,
            120,
            125,
            105,
            110,
            170
          ],
          'borderColor': ChartjsTemplateUtils.chartColors['green'],
          'backgroundColor': 'rgba(0, 0, 0, 0)',
          'fill': false,
          'lineTension': 0
        }
      ]
    },
    'options': {
      'responsive': true,
      'title': {
        'display': true,
        'text': 'Chart.js Line Chart - Cubic interpolation mode'
      },
      'tooltips': {'mode': 'index'},
      'scales': {
        'xAxes': [
          {
            'display': true,
            'scaleLabel': {
              'display': true,
            }
          }
        ],
        'yAxes': [
          {
            'display': true,
            'scaleLabel': {
              'display': true,
              'labelString': 'Value',
            },
            'suggestedMin': -10,
            'suggestedMax': 200,
          }
        ]
      },
    }
  },
};