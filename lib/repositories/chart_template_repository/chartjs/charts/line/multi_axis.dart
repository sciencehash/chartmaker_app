import '../../../../../utils/chartjs_template_utils.dart';

final Map chartjs_multi_axis_line = {
  'id': 'chartjs-multi-axis-line',
  'lib': 'chartjs',
  'title': 'Multi Axis Line Chart',
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
          'borderColor': ChartjsTemplateUtils.chartColors['red'],
          'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
          'fill': false,
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'yAxisID': 'y-axis-1',
        },
        {
          'label': 'My Second dataset',
          'borderColor': ChartjsTemplateUtils.chartColors['blue'],
          'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
          'fill': false,
          'data': [
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor(),
            ChartjsTemplateUtils.randomScalingFactor()
          ],
          'yAxisID': 'y-axis-2'
        }
      ]
    },
    'options': {
      'responsive': true,
      'hoverMode': 'index',
      'stacked': false,
      'title': {'display': true, 'text': 'Chart.js Line Chart - Multi Axis'},
      'scales': {
        'yAxes': [
          {
            // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            'type': 'linear',
            'display': true,
            'position': 'left',
            'id': 'y-axis-1',
          },
          {
            // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            'type': 'linear',
            'display': true,
            'position': 'right',
            'id': 'y-axis-2',

            // grid line settings
            'gridLines': {
              // only want the grid lines for one axis to show up
              'drawOnChartArea': false,
            },
          }
        ],
      }
    }
  },
};
