import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_steeped_line_line = {
  'id': 'chartjs-stepped-line',
  'lib': 'chartjs',
  'title': 'Stepped Line Chart',
  'config': {
    'type': 'line',
    'data': {
      'labels': ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6'],
      'datasets': [
        {
          'label': 'stepped: true',
          'steppedLine': true,
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'borderColor': ChartjsTemplateUtils.chartColors['green'],
          'fill': false,
        }
      ]
    },
    'options': {
      'responsive': true,
      'title': {
        'display': true,
        'text': 'Step Before Interpolation',
      }
    }
  },
};