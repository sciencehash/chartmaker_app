import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_multi_axis_bar = {
  'id': 'chartjs-multi-axis-bar',
  'lib': 'chartjs',
  'title': 'Multi Axis Bar Chart',
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
          'backgroundColor': [
            ChartjsTemplateUtils.chartColors['red'],
            ChartjsTemplateUtils.chartColors['orange'],
            ChartjsTemplateUtils.chartColors['yellow'],
            ChartjsTemplateUtils.chartColors['green'],
            ChartjsTemplateUtils.chartColors['blue'],
            ChartjsTemplateUtils.chartColors['purple'],
            ChartjsTemplateUtils.chartColors['red'],
          ],
          'yAxisID': 'y-axis-1',
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
          'backgroundColor': ChartjsTemplateUtils.chartColors['grey'],
          'yAxisID': 'y-axis-2',
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
      'title': {
        'display': true,
        'text': 'Chart.js Bar Chart - Multi Axis',
      },
      'tooltips': {
        'mode': 'index',
        'intersect': true,
      },
      'scales': {
        'yAxes': [
          {
            'type': 'linear',
            // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            'display': true,
            'position': 'left',
            'id': 'y-axis-1',
          },
          {
            'type': 'linear',
            // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            'display': true,
            'position': 'right',
            'id': 'y-axis-2',
            'gridLines': {
              'drawOnChartArea': false,
            }
          }
        ],
      }
    }
  },
};