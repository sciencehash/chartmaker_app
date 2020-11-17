import 'package:chartmaker_app/utils/template_data/apexcharts_annotations_line.dart';

final Map apexcharts_annotations_line = {
  'id': 'apexcharts-annotations-line',
  'lib': 'apexcharts',
  'title': 'Line Chart with Annotations',
  'config': {
    'chart': {'height': 350, 'type': 'line', 'id': 'areachart-2'},
    'annotations': {
      'yaxis': [
        {
          'y': 8200,
          'borderColor': '#00E396',
          'label': {
            'borderColor': '#00E396',
            'style': {
              'color': '#fff',
              'background': '#00E396',
            },
            'text': 'Support',
          }
        },
        {
          'y': 8600,
          'y2': 9000,
          'borderColor': '#000',
          'fillColor': '#FEB019',
          'opacity': 0.2,
          'label': {
            'borderColor': '#333',
            'style': {
              'fontSize': '10px',
              'color': '#333',
              'background': '#FEB019',
            },
            'text': 'Y-axis range',
          }
        }
      ],
      'xaxis': [
        {
          'x': DateTime.parse('2017-11-23').millisecondsSinceEpoch,
          'strokeDashArray': 0,
          'borderColor': '#775DD0',
          'label': {
            'borderColor': '#775DD0',
            'style': {
              'color': '#fff',
              'background': '#775DD0',
            },
            'text': 'Anno Test',
          }
        },
        {
          'x': DateTime.parse('2017-11-26').millisecondsSinceEpoch,
          'x2': DateTime.parse('2017-11-28').millisecondsSinceEpoch,
          'fillColor': '#B3F7CA',
          'opacity': 0.4,
          'label': {
            'borderColor': '#B3F7CA',
            'style': {
              'fontSize': '10px',
              'color': '#fff',
              'background': '#00E396',
            },
            'offsetY': -10,
            'text': 'X-axis range',
          }
        }
      ],
      'points': [
        {
          'x': DateTime.parse('2017-12-01').millisecondsSinceEpoch,
          'y': 8607.55,
          'marker': {
            'size': 8,
            'fillColor': '#fff',
            'strokeColor': 'red',
            'radius': 2,
            'cssClass': 'apexcharts-custom-class'
          },
          'label': {
            'borderColor': '#FF4560',
            'offsetY': 0,
            'style': {
              'color': '#fff',
              'background': '#FF4560',
            },
            'text': 'Point Annotation',
          }
        },
        {
          'x': DateTime.parse('2017-12-08').millisecondsSinceEpoch,
          'y': 9340.85,
          'marker': {'size': 0},
          // 'image': {'path': '../../assets/images/ico-instagram.png'}
        }
      ]
    },
    'dataLabels': {'enabled': false},
    'stroke': {'curve': 'straight'},
    'grid': {
      'padding': {'right': 30, 'left': 20}
    },
    'title': {'text': 'Line with Annotations', 'align': 'left'},
    'labels': apexcharts_annotations_line_series['monthDataSeries1']
    ['dates'],
    'xaxis': {
      'type': 'datetime',
    },
    'series': [
      {
        'data': apexcharts_annotations_line_series['monthDataSeries1']
        ['prices']
      }
    ],
  },
};