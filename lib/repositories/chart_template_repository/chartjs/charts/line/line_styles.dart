import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_line_style = {
  'id': 'chartjs-line-style',
  'lib': 'chartjs',
  'title': 'Line Style Chart',
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
          'label': 'Unfilled',
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
        },
        {
          'label': 'Dashed',
          'fill': false,
          'backgroundColor': ChartjsTemplateUtils.chartColors['green'],
          'borderColor': ChartjsTemplateUtils.chartColors['green'],
          'borderDash': [5, 5],
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
        },
        {
          'label': 'Filled',
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
          'fill': true,
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
      'hover': {'mode': 'nearest', 'intersect': true},
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