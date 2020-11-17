import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_horizontal_bar = {
  'id': 'chartjs-horizontal-bar',
  'lib': 'chartjs',
  'title': 'Horizontal Bar Chart',
  'config': {
    'type': 'horizontalBar',
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
      // Elements options apply to all of the options unless overridden in a dataset
      // In this case, we are setting the border of each horizontal bar to be 2px wide
      'elements': {
        'rectangle': {
          'borderWidth': 2,
        }
      },
      'responsive': true,
      'legend': {
        'position': 'right',
      },
      'title': {
        'display': true,
        'text': 'Chart.js Horizontal Bar Chart',
      }
    }
  },
};