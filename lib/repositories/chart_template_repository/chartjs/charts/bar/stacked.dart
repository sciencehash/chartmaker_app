import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_stacked_bar = {
  'id': 'chartjs-stacked-bar',
  'lib': 'chartjs',
  'title': 'Stacked Bar Chart',
  'config': {
    'type': 'bar',
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
          'label': 'Dataset 1',
          'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ]
        },
        {
          'label': 'Dataset 2',
          'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ]
        },
        {
          'label': 'Dataset 3',
          'backgroundColor': ChartjsTemplateUtils.chartColors['green'],
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ]
        }
      ]
    },
    'options': {
      'title': {
        'display': true,
        'text': 'Chart.js Bar Chart - Stacked',
      },
      'tooltips': {
        'mode': 'index',
        'intersect': false,
      },
      'responsive': true,
      'scales': {
        'xAxes': [
          {
            'stacked': true,
          }
        ],
        'yAxes': [
          {'stacked': true}
        ]
      }
    }
  },
};