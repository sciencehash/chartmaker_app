import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_stacked_group_bar = {
  'id': 'chartjs-stacked-group-bar',
  'lib': 'chartjs',
  'title': 'Stacked Group Bar Chart',
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
          'stack': 'Stack 0',
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
          'stack': 'Stack 0',
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
          'stack': 'Stack 1',
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
      'title': {'display': true, 'text': 'Chart.js Bar Chart - Stacked'},
      'tooltips': {'mode': 'index', 'intersect': false},
      'responsive': true,
      'scales': {
        'x': {
          'stacked': true,
        },
        'y': {'stacked': true}
      }
    }
  },
};