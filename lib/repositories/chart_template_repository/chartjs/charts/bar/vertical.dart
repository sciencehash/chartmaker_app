import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_vertical_bar = {
  'id': 'chartjs-vertical-bar',
  'lib': 'chartjs',
  'title': 'Vertical Bar Chart',
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
          'borderColor': ChartjsTemplateUtils.chartColors['red'],
          'borderWidth': 1,
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
          'borderColor': ChartjsTemplateUtils.chartColors['blue'],
          'borderWidth': 1,
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
      'responsive': true,
      'legend': {
        'position': 'top',
      },
      'title': {'display': true, 'text': 'Chart.js Bar Chart'}
    }
  },
};