import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_point_size_line = {
  'id': 'chartjs-point-size-line',
  'lib': 'chartjs',
  'title': 'Point Size Line Chart',
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
          'label': 'dataset - big points',
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
          'borderColor': ChartjsTemplateUtils.chartColors['red'],
          'fill': false,
          'borderDash': [5, 5],
          'pointRadius': 15,
          'pointHoverRadius': 10,
        },
        {
          'label': 'dataset - individual point sizes',
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
          'borderColor': ChartjsTemplateUtils.chartColors['blue'],
          'fill': false,
          'borderDash': [5, 5],
          'pointRadius': [2, 4, 6, 18, 0, 12, 20],
        },
        {
          'label': 'dataset - large pointHoverRadius',
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'backgroundColor': ChartjsTemplateUtils.chartColors['green'],
          'borderColor': ChartjsTemplateUtils.chartColors['green'],
          'fill': false,
          'pointHoverRadius': 30,
        },
        {
          'label': 'dataset - large pointHitRadius',
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'backgroundColor': ChartjsTemplateUtils.chartColors['yellow'],
          'borderColor': ChartjsTemplateUtils.chartColors['yellow'],
          'fill': false,
          'pointHitRadius': 20,
        }
      ]
    },
    'options': {
      'responsive': true,
      'legend': {
        'position': 'bottom',
      },
      'hover': {'mode': 'index'},
      'scales': {
        'x': {
          'display': true,
          'scaleLabel': {'display': true, 'labelString': 'Month'}
        },
        'y': {
          'display': true,
          'scaleLabel': {'display': true, 'labelString': 'Value'}
        }
      },
      'title': {
        'display': true,
        'text': 'Chart.js Line Chart - Different point sizes'
      }
    }
  },
};