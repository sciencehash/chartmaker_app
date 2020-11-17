// final Map apexcharts_zoomable_timeseries_line = {
//   'id': 'apexcharts-zoomable-timeseries-line',
//   'lib': 'apexcharts',
//   'title': 'Zoomable TimeSeries Line Chart',
//   'config': {
//     'chart': {
//       'type': 'area',
//       'stacked': false,
//       'height': 350,
//       'zoom': {
//         'type': 'x',
//         'enabled': true,
//         'autoScaleYaxis': true
//       },
//       'toolbar': {
//         'autoSelected': 'zoom'
//       }
//     },
//     'dataLabels': {
//       'enabled': false
//     },
//     'markers': {
//       'size': 0,
//     },
//     'title': {
//       'text': 'Stock Price Movement',
//       'align': 'left'
//     },
//     'fill': {
//       'type': 'gradient',
//       'gradient': {
//         'shadeIntensity': 1,
//         'inverseColors': false,
//         'opacityFrom': 0.5,
//         'opacityTo': 0,
//         'stops': [0, 90, 100]
//       },
//     },
//     'yaxis': {
//       'labels': {
//         'formatter': (val) {
//           return (val / 1000000).toFixed(0);
//         },
//       },
//       'title': {
//         'text': 'Price'
//       },
//     },
//     'xaxis': {
//       'type': 'datetime',
//     },
//     'tooltip': {
//       'shared': false,
//       'y': {
//         'formatter': (val) {
//           return (val / 1000000).toFixed(0);
//         }
//       }
//     },
//     'series': [{
//       'name': 'XYZ MOTORS',
//       'data': getData(),
//     }
//     ]
//   },
// };