import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_basic_line = {
  'id': 'chartjs-basic-line',
  'lib': 'chartjs',
  'title': 'Basic Line Chart',
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
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'fill': false,
        },
        {
          'label': 'My Second dataset',
          'fill': false,
          'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
          'borderColor': ChartjsTemplateUtils.chartColors['blue'],
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
        }
      ]
    },
    'options': {
      'responsive': true,
      'title': {'display': true, 'text': 'Chart.js Line Chart'},
      'tooltips': {
        'mode': 'index',
        'intersect': false,
      },
      'hover': {
        'mode': 'nearest',
        'intersect': true,
      },
      'scales': {
        'xAxes': [
          {
            'display': true,
            'scaleLabel': {
              'display': true,
              'labelString': 'Month',
            }
          }
        ],
        'yAxes': [
          {
            'display': true,
            'scaleLabel': {
              'display': true,
              'labelString': 'Value',
            }
          }
        ]
      }
    }
  },
};
